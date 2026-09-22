variable "aws_region" {
  description = "AWS region to deploy the resources"
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "prod"
}

variable "public_subnet_cidr" {
  description = "CIDR blocks for the public subnets"
  type        = list(string)
  default     = [
    "10.0.1.0/24", 
    "10.0.2.0/24"
  ]
}

variable "public_subnet_az" {
  description = "AZ for the public subnets"
  type        = list(string)
  default     = [
    "us-east-1a",
    "us-east-1b"
  ]
}

variable "ingres_cidr_block" {
  description = "CIDR blocks for the private subnets"
  type        = string
  default     = "0.0.0.0/0"
}

variable "my_ip" {
  description = "My IP address"
  type        = string
  default     = "190.61.41.12/32"
}

variable "egress_cidr_block" {
  description = "CIDR blocks for the private subnets"
  type        = string
  default     = "0.0.0.0/0"
}