variable "environment" {
  description = "Environment name"
  type        = string
  default     = "prod"
}

variable "security_group_id" {
  description = "Security group ID"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID"
  type        = list(string)
}
