provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source = "../../modules/vpc"
  
  vpc_cidr_block     = module.vpc_cidr_block
  public_subnet_cidr = module.public_subnet_cidr
  public_subnet_az   = module.public_subnet_az
  my_ip              = module.my_ip
}
