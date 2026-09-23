output "lambda_function_name" {
  description = "lambda function name"
  value       = aws_lambda_function.finops_ec2_stopper.function_name
}

output "lambda_role_arn" {
  description = "lambda role arn"
  value       = aws_iam_role.finops_lambda_role.arn
}