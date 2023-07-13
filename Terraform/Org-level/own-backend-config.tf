module "org_level_backend" {
  source            = "./s3-backend-module"
  bucket_name       = "terraform-org-level-state"
  dynamodb_table    = "terraform-org-level-locks"
  bucket_versioning = "Enabled"
}