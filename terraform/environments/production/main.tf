provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source = "../modules/vpc"
  
  vpc_cidr_block     = var.vpc_cidr_block
  public_subnet_cidr = var.public_subnet_cidr
  public_subnet_az   = var.public_subnet_az
  my_ip              = var.my_ip
}
