terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.5.0"
    }
  }
    backend "local" {
    path = "terraform.tfstate"
  }
}

provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.0.0"
}

module "tfstate" {
  source  = "squareops/tfstate/aws"
  version = "1.0.1"
}

# module "vpc" {
#   source  = "terraform-aws-modules/vpc/aws"
#   version = "5.0.0"

#   name = "${var.environment_name}-vpc"
#   cidr = var.vpc_cidr_block

#   azs             = ["${var.region}a"]
#   private_subnets = ["${var.private_subnet}"]
#   public_subnets  = ["${var.public_subnet}"]
# #   database_subnets = []

#   create_database_subnet_group = false
#   enable_nat_gateway = false
#   enable_vpn_gateway = false

#   # manage_default_vpc = true


#   tags = {
#     name        = "${var.environment_name}-vpc"
#     Environment = var.environment_name
#   }
# }