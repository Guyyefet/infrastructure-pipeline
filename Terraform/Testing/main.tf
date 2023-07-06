terraform {
  backend "s3" {
    bucket = "terraform-testing-env-state"
    key    = "global/s3/terraform.tfstate"
    region = "us-east-1"
    # profile = "devops_user"

    dynamodb_table = "terraform-testing-env-locks"
    encrypt        = true
    # shared_credentials_file = "$HOME/.aws/credentials"
  }

    # backend "local" {
    # path = "terraform.tfstate"
}

