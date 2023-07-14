output "ALB-DNS" {
    description = "ID of Application Load balancer SG"
    value =  try(aws_lb.ALB.dns_name ,"")
}

/* 
output "TGARN" {
  value = try(aws_lb_target_group.this.arn ,"")
} */