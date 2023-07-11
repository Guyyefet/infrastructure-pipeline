terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.7.0"
    }
  }
    backend "s3" {
    bucket         = "terraform-org-level-state"
    key            = "global/s3/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-org-level-locks"
    encrypt        = true
  }
  #   backend "local" {
  #   path = "terraform.tfstate"
}