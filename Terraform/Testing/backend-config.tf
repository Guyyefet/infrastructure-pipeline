module "backend" {
  source             = "../.terraform/modules/s3-backend"
  bucket_name        = "terraform-testing-env-state" 
  dynamodb_table     = "terraform-testing-env-locks"
  # versioning_enabled = true
}

