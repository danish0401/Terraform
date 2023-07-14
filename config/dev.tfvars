vpc = {
  vpc-cidr             = "10.0.0.0/16"
  public-subnets-cidr  = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24", "10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  private-subnets-cidr = ["10.0.7.0/24"]
}
/* azs=["us-west-2a", "us-west-2b"] */

# "Enter Environment name for your Configuration. Default is Test."
# Allowed values: test, prod, dev 
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