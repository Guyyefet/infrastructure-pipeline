locals {
  vpc_name = "${var.environment_name}-vpc"

}

module "dev_vpc" {
  source = "../.terraform/modules/vpc"

  name = local.vpc_name
  cidr = var.vpc_cidr_block

  azs             = var.availability_zones
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets
#   database_subnets = []

  create_database_subnet_group = false
  enable_nat_gateway = false
  enable_vpn_gateway = false

  # manage_default_vpc = true


  # tags = {
  #   Name        = "${var.environment_name}-vpc"
  #   Environment = var.environment_name
  #   Team = var.team_name
  # }
}