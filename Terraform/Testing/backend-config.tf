module "backend" {
  source             = "../.terraform/modules/s3-backend"
  bucket_name        = "terraform-testing-env-state" 
  dynamodb_table     = "terraform-testing-env-locks"
  bucket_versioning = "Enabled"
}

