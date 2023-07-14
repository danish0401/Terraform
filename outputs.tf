output "VPC_ID" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "Vpc_arn" {
  description = "The ARN of the VPC"
  value       = module.vpc.vpc_arn
}

output "Subnet-public-1-id" {
  description = "subnet id of subnet in us-west-2-a"
  value       = module.vpc.subnet-public-1
}

/* output "Subnet-public-2-id" {
  description = "subnet id of subnet in us-west-2-b"
  value       = module.vpc.subnet-public-2
} */

/* output "Subnet-public-3-id" {
  description = "subnet id of subnet in us-west-2-c"
  value       = module.vpc.subnet-public-3
} */

/* output "Subnet-private-1-id" {
  description = "subnet id of private subnet in us-west-2-a"
  value       = module.vpc.subnet-private-1
}

output "Subnet-private-2-id" {
  description = "subnet id of private subnet in us-west-2-b"
  value       = module.vpc.subnet-private-2
} */

/* output "Subnet-private-3-id" {
  description = "subnet id of private subnet in us-west-2-b"
  value       = module.vpc.subnet-private-3
} */

/* 
output "alb-SG-ID" {
    description = "ID of Application Load balancer SG"
    value =  module.secgroups.ALB-SG-ID
}

output "webserver-SG-ID" {
    description = "ID of Application Server balancer SG"
    value =  module.secgroups.ALB-SG-ID
}

output "db-SG-ID" {
    description = "ID of Application DB balancer SG"
    value =  module.secgroups.ALB-SG-ID
}


output "instance_Id" {
  value = module.ec2-public.id
  
}

output "NLB-DNS" {
  value = module.NLB.NLB-DNS
}

output "ALB-DNS" {
  value = module.ALB.ALB-DNS
} */
