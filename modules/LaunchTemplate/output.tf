output "id" {
  description = "The ID of the instance"
  value       = try(aws_launch_template.myLT.id, "")
}

output "arn" {
  description = "The ARN of the instance"
  value       = try(aws_launch_template.myLT.arn, "")
}
