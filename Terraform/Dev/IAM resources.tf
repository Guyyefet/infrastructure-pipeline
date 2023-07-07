module "iam_github_oidc_provider" {
  source    = "../.terraform/modules/iam_github_oidc_provider/modules/iam-github-oidc-provider"


#   client_id_list = ["https://github.com/Guyyefet/infrastructure-pipeline.git"]

  tags = {
    Environment = var.environment_name
  }
}

module "iam_github_oidc_role" {
  source    = "../.terraform/modules/iam_github_oidc_role/modules/iam-github-oidc-role"

  name = "terraform-plan-role"
  
  subjects = ["terraform-aws-modules/terraform-aws-iam:*",
              "Guyyefet/infrastructure-pipeline:*"]

  policies = {
    S3ReadOnly = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
  }

  tags = {
    Environment = var.environment_name
  }
}