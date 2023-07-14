output "ALB-SG-ID" {
    description = "ID of Application Load balancer SG"
    value =  try(aws_security_group.ALB-sec-group.id,"")
}

output "WebServer-SG-ID" {
    description = "ID of Application Server balancer SG"
    value =  try(aws_security_group.WS-sec-group.id,"")
}

output "DB-SG-ID" {
    description = "ID of Application DB balancer SG"
    value =  try(aws_security_group.DB-sec-group.id,"")
}
