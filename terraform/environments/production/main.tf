provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source = "../../modules/vpc"
}

module "compute" {
  source            = "../../modules/compute"
  security_group_id = module.vpc.security_group_id
  subnet_id         = module.vpc.public_subnet_id
}

module "finops" {
  source      = "../../modules/finops"
  environment = "production"
}
