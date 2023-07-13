module "environments_backend" {
  source            = "./s3-backend-module"

  for_each = toset(var.environments)

  bucket_name       = "my-super-unique-${each.key}-env-state"
  dynamodb_table    = "my-super-unique-${each.key}-env-locks"
  bucket_versioning = "Enabled"
}