output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.swo_vpc.id
}

output "public_subnet_id" {
  description = "The ID of the public subnet"
  value       = [
    aws_subnet.public_subnet_1.id, 
    aws_subnet.public_subnet_2.id
  ]
}

output "security_group_id" {
  description = "The ID of the security group"
  value       = [
    aws_security_group.swo_sg.sg_id
  ]
}