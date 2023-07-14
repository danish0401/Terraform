
resource "aws_instance" "myec2" {
  ami                    = var.instance_ami
  instance_type          = var.instance_type
  subnet_id              = var.subnet
  key_name               = var.pub_key
  vpc_security_group_ids = var.secgroups
  iam_instance_profile   = var.SSMProfileName
  user_data              = "${file(var.userdatafilepath)}"

  tags = {
    Name = "${var.name}-${terraform.workspace}-${var.postfix}"
  }
}