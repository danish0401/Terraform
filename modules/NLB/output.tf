output "NLB-DNS" {
    description = "ID of Network Load balancer SG"
    value =  try(aws_lb.this.dns_name ,"")
}
