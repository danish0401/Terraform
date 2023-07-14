variable "vpc" {
  type = object({
    vpc-cidr             = string
    public-subnets-cidr  = list(string)
    private-subnets-cidr = list(string)
  })
  default = {
    vpc-cidr             = "10.0.0.0/16"
    public-subnets-cidr = ["10.0.1.0/24", "10.0.2.0/24"]
    private-subnets-cidr  = ["10.0.3.0/24", "10.0.4.0/24"]
  }
}

variable "name" {
  default = "K-Cluster"
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
      "8080" = ["0.0.0.0/0"]
      "5000" = ["0.0.0.0/0"]
  }
}

variable "DB-ingress" {
    type = map

  default = {
      "3306"  = ["0.0.0.0/0"]
      "22"  = ["0.0.0.0/0"]
  }
}


# Ec2 vars

variable "instance_ami" {
    type = string
    default = "ami-0d593311db5abb72b"
}

variable "instance_type" {
    type = string
    default = "t2.micro"
}

variable "key" {
    type = string
    default = "DanishKey"
}


variable "userdatafilepath" {
  type = string
  default = "scripts/jenkins.sh"
}

variable "webuserdata" {
  type = string 
  default = "scripts/wordpress.sh"
}

variable "dbuserdata" {
  type = string 
  default = "scripts/database.sh"
}

variable "postfix" {
  type = string
  default = ""
}

# ALB vars
variable "ALB_vars" {
  type = object({
    deregistration_delay = number
    HC_interval = number
    HC_healthy_threshold = number
    HC_unhealthy_threshold = number
    HC_timeout = number
    protocol = string
    port = number
  })

 default = {
    HC_healthy_threshold = 5
    HC_interval = 10
    HC_timeout = 5
    HC_unhealthy_threshold = 2
    deregistration_delay = 60
    protocol = "HTTP"
    port = 80
  }

}

/*
# ASG vars


variable "LT_id" {
  default = ""
  type    = string
}

variable "min_size" {
    type = number
    default = 2
}

variable "max_size" {
    type = number
    default = 4
}

variable "desired_capacity" {
    type = number
    default = 2
}

variable "default_cooldown" {
    type = number
    default = 60
}

variable "target_group_arns" {
    type = list(string)
    default = [ "" ]
}


variable "health_check_grace_period" {
    type = number
    default = 60  
}

variable "email" {
    type = string
    default = "danish.hafeez76@gmail.com"
}

 */
