data "template_file" init {
  template = "${file(var.userdatafilepath)}"
  
  vars = {
    db_dns = var.NLBDNS
  }
}

resource "aws_launch_template" "myLT" {
    name = "${var.name}-${terraform.workspace}-${var.postfix}"
    image_id               = var.instance_ami
    instance_type          = var.instance_type
    key_name               = var.pub_key
    vpc_security_group_ids = var.secgroups
    iam_instance_profile {
        name = var.SSMProfileName
    } 
    user_data              = base64encode("${data.template_file.init.rendered}")

    tags = {
        Name = "${var.name}-${terraform.workspace}-${var.postfix}"
  }
}