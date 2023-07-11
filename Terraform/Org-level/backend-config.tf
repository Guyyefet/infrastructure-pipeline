module "org_level_backend" {
  source            = "../.terraform/modules/s3-backend"
  bucket_name       = "terraform-org-level-state"
  dynamodb_table    = "terraform-org-level-locks"
  bucket_versioning = "Enabled"
}