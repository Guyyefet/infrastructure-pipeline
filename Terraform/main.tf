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

module "s3-backend" {
  source            = "./org-level/s3-backend-module"
}

# provider "tls" {
#   proxy {
#     url = "https://corporate.proxy.service"
#   }
# }

# module "vpc" {
#   source  = "terraform-aws-modules/vpc/aws"
#   version = "5.0.0"
# }

# module "iam_github_oidc_provider" {
#   source    = "terraform-aws-modules/iam/aws//modules/iam-github-oidc-provider"
#   version = " 5.27.0"
# }

# module "iam_github_oidc_role" {
#   source    = "terraform-aws-modules/iam/aws//modules/iam-github-oidc-role"
#   version = " 5.27.0"
# }

