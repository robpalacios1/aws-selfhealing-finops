output "asg_name" {
  description = "ASG Name"
  value       = aws_autoscaling_group.swo_asg.name
}

output "asg_arn" {
  description = "ASG ARN"
  value       = aws_autoscaling_group.swo_asg.arn
}