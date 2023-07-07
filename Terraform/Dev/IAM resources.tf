module "iam_github_oidc_provider" {
  source    = "../.terraform/modules/iam_github_oidc_provider"

#   client_id_list = ["https://github.com/Guyyefet/infrastructure-pipeline.git"]

  tags = {
    Environment = var.environment_name
  }
}

module "iam_github_oidc_role" {
  source    = "../.terraform/modules/iam_github_oidc_role"

  name = "terraform plan role"
  # This should be updated to suit your organization, repository, references/branches, etc.
  subjects = ["terraform-aws-modules/terraform-aws-iam:*"]

  policies = {
    S3ReadOnly = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
  }

  tags = {
    Environment = var.environment_name
  }
}