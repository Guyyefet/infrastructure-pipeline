# module "backend" {
#   source            = "../My-modules/s3-backend"
#   bucket_name       = "terraform-dev-env-state"
#   dynamodb_table    = "terraform-dev-env-locks"
#   bucket_versioning = "Enabled"
# }