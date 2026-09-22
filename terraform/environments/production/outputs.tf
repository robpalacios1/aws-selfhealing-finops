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