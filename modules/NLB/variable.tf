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

variable "NLB_vars" {
  type = object({
    HC_interval = number
    HC_healthy_threshold = number
    HC_unhealthy_threshold = number
    protocol = string
    port = number
  })

  default = {
    HC_healthy_threshold = 3
    HC_interval = 30
    HC_unhealthy_threshold = 3
    port = 3306
    protocol = "TCP"
  }
}