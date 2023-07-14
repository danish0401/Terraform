
# Security Groups

resource "aws_security_group" "ALB-sec-group" {
  name        = "ALB-sec-group"
  description = "Enable HTTP from 0.0.0.0/0"
  vpc_id      = var.vpc_id

  dynamic ingress {
    for_each = var.ALB-ingress
    content{
      from_port   = ingress.key
      to_port     = ingress.key
      cidr_blocks = ingress.value
      protocol    = "tcp"
    }
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  tags = {
    Name = "${var.name}-${terraform.workspace}-ALB-SG"
  }
}

resource "aws_security_group" "WS-sec-group" {
  
  name        = "WS-sec-group"
  description = "Enable HTTP from Internet"
  vpc_id      = var.vpc_id

  dynamic ingress {
    for_each = var.server-ingress
    content{
      from_port   = ingress.key
      to_port     = ingress.key
      cidr_blocks = ingress.value
      protocol    = "tcp"
    }
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  tags = {
    Name = "${var.name}-${terraform.workspace}-WS-SG"
  }
}

resource "aws_security_group" "DB-sec-group" {
  name        = "DB-sec-group"
  description = "Enable 3306 from Webserver"
  vpc_id      = var.vpc_id


  dynamic ingress {
    for_each = var.DB-ingress
    content{
      from_port   = ingress.key
      to_port     = ingress.key
      cidr_blocks = ingress.value
      protocol    = "tcp"
    }
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  tags = {
    Name = "${var.name}-${terraform.workspace}-DB-SG"
  }
}
