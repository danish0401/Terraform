vpc = {
  vpc-cidr             = "10.0.0.0/16"
  private-subnets-cidr = ["10.0.1.0/24", "10.0.2.0/24"]
  public-subnets-cidr  = ["10.0.3.0/24", "10.0.4.0/24"]
}

# "Enter Environment name for your Configuration. Default is Test."
# Allowed values: test, prod, dev 
# resource tagging pre-fix name 
name = "danish"


# Sec Group Details
ALB-ingress = {
  "80" = [ "0.0.0.0/0" ]
}

server-ingress = {
  "80"  = ["0.0.0.0/0"]
  "22"  = ["0.0.0.0/0"]
}

DB-ingress = {
  "3306"  = ["0.0.0.0/0"]
  "22"  = ["0.0.0.0/0"]
}

ALB_vars = {
    HC_healthy_threshold = 5
    HC_interval = 10
    HC_timeout = 5
    HC_unhealthy_threshold = 2
    deregistration_delay = 60
    protocol = "HTTP"
    port = 80
}