/* /* /* resource "aws_key_pair" "my_key_pair" {
  key_name   = var.pub_key
  public_key = file("${abspath(path.cwd)}/mynewkey.pub")
} */
/* 
data "aws_subnets" "example" {
  filter {\
    name   = "vpc-id"
    values = [ try(module.vpc.vpc_id, "") ]
  }

  tags = {
    Tier = "public"
  }
}

data "aws_subnet" "example" {
  for_each = toset(data.aws_subnets.example.ids)
  id       = each.value
}

output "subnet_Ids" {
  #value = [for s in data.aws_subnet.example : s.id]
    value = data.aws_subnets.example.ids)
} 
 */ 

/* data "template_file" init {
  template = "${file("scripts/wordpress.sh")}"
  
  vars = {
    db_dns = "${module.NLB.NLB-DNS}"
  }
}

output "subnet_Ids" {
    value = "${data.template_file.init.rendered}"
} */

/* # Declare the data source
data "aws_availability_zones" "available" {
  state = "available"
}

output "xyz" {
  value = [ "${data.aws_availability_zones.available.names[0]}" , "${data.aws_availability_zones.available.names[1]}" ]
} */

/* output "TGARN" {
  value = [ try( module.ALB.TGARN, "") ]
} */

/* data "template_file" init {
  template = "${file("scripts/wordpress.sh")}"
  
  vars = {
    db_dns = "${module.NLB.NLB-DNS}"
  }
}

resource "aws_instance" "myec2" {
  ami                    = var.instance_ami
  instance_type          = var.instance_type
  subnet_id              = try(module.vpc.subnet-public-1, "")
  key_name               = "DanishKey"
  vpc_security_group_ids = ["${try(module.secgroups.WebServer-SG-ID,"")}"]
  iam_instance_profile   = try(module.ssmrole.SSMProfile,"")
  user_data              = "${data.template_file.init.rendered}"

  tags = {
    Name = "${var.name}-${terraform.workspace}-${var.postfix}"
  }
} */

/* resource "aws_dynamodb_table" "state_locking" {
  hash_key = "LockID"
  name     = "dynamodb-state-locking"
  attribute {
    name = "LockID"
    type = "S"
  }
  billing_mode = "PAY_PER_REQUEST"
} */

