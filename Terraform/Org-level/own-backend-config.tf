module "org_level_backend" {
  source            = "./s3-backend-module"
  bucket_name       = "terraform-org-level-state"
  dynamodb_table    = "terraform-org-level-locks"
  bucket_versioning = "Enabled"

  policy_principal_identifiers = [
    "${data.aws_caller_identity.current.account_id}",
    "${module.terraform-plan-role.arn}",
    "${module.infrastructre-group.group_arn}"
    ]  
}

data "aws_caller_identity" "current" {}