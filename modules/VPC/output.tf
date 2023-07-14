output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}

output "vpc_arn" {
  description = "The ARN of the VPC"
  value       = aws_vpc.main.arn
}

output "subnet-public-1" {
  description = "subnet id of subnet in us-west-2-a"
  value       = aws_subnet.public[0].id
}

/* output "subnet-public-2" {
  description = "subnet id of subnet in us-west-2-b"
  value       = aws_subnet.public[1].id
} */
/* 
output "subnet-public-3" {
  description = "subnet id of subnet in us-west-2-c"
  value       = try(aws_subnet.public[2].id, "")
} */

 /* output "subnet-private-1" {
  description = "subnet id of subnet in us-west-2-a"
  value       = aws_subnet.private[0].id
} */
/*
output "subnet-private-2" {
  description = "subnet id of subnet in us-west-2-b"
  value       = aws_subnet.private[1].id
} */

/* output "subnet-private-3" {
  description = "subnet id of subnet in us-west-2-c"
  value       = try(aws_subnet.private[2].id, "")
} */

