# ====================================================================
# VPC outputs
# ====================================================================

output "prod_vpc_id" {
  description = "The ID of the production VPC"
  value       = module.vpc.vpc_id
}

output "prod_public_subnet_id" {
  description = "The ID of the production public subnet"
  value       = module.vpc.public_subnet_id
}

output "prod_security_group_id" {
  description = "The ID of the production security group"
  value       = module.vpc.security_group_id
}

# ====================================================================
# Create ASG outputs
# ====================================================================

output "prod_asg_name" {
  description = "ASG Name"
  value       = module.compute.asg_name
}

output "prod_asg_arn" {
  description = "ASG ARN"
  value       = module.compute.asg_arn
}