variable "instance_ami" {
  type    = string
  default = "ami-005e54dee72cc1d00"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "subnet" {
  type = string
}

variable "pub_key" {
  type = string
}

variable "secgroups" {
  type    = list(string)
  default = [""]
}

variable "SSMProfileName" {
  type    = string
  default = ""
}

variable "name" {
  default = "Danish"
  type    = string
}

variable "userdatafilepath" {
  type = string
  default = ""
}

variable "postfix" {
  type = string
  default = ""
}