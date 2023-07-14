variable "vpc_id" {
  type    = string
}

variable "name" {
  default = "danish"
  type    = string
}

variable "ports" {
  type    = map(number)
  default = {
    sql = 3306
  }
}

variable "db_id" {
    type = string
    default = ""
}

variable "secgroups" {
  type    = list(string)
  default = [""]
}

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

