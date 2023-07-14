output "id" {
  description = "The ID of the instance"
  value       = try(aws_instance.myec2.id, "")
}

output "arn" {
  description = "The ARN of the instance"
  value       = try(aws_instance.myec2.arn, "")
}