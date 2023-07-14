
variable "vpc" {
  type = object({
    vpc-cidr             = string
    public-subnets-cidr  = list(string)
    private-subnets-cidr = list(string)
  })
  default = {
    vpc-cidr             = "10.0.0.0/16"
    private-subnets-cidr = ["10.0.1.0/24", "10.0.2.0/24"]
    public-subnets-cidr  = ["10.0.3.0/24", "10.0.4.0/24"]
  }
}

variable "name" {
  default = "danish"
  type    = string
}
