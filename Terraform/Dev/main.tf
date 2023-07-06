terraform {
  backend "s3" {
    bucket = "terraform-devenv-state"
    key    = "global/s3/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "terraform-devenv-locks"
    encrypt        = true
  }
  #   backend "local" {
#     path = "terraform.tfstate"
#   }
}



