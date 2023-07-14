variable "vpc_id" {
  type    = string
}

variable "name" {
  default = "danish"
  type    = string
}

variable "ALB-ingress" {
    type = map

  default = {
      "80"  = ["0.0.0.0/0"]
  }
}
variable "server-ingress" {
    type = map

  default = {
      "80"  = ["0.0.0.0/0"]
      "22"  = ["0.0.0.0/0"]
  }
}

variable "DB-ingress" {
    type = map

  default = {
      "3306"  = ["0.0.0.0/0"]
      "22"  = ["0.0.0.0/0"]
  }
}