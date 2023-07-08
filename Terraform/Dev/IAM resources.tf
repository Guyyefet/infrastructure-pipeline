module "aws_iam_policy" {
  source    = "../.terraform/modules/iam_github_oidc_provider/modules/iam-policy"

  name = "store-terraform-state-file-in-bucket"

   policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "s3:ListBucket",
      "Resource": "arn:aws:s3:::terraform-dev-env-state"
    },
    {
      "Effect": "Allow",
      "Action": [
        "s3:GetObject",
        "s3:PutObject",
        "s3:DeleteObject"
      ],
      "Resource": [
        "arn:aws:s3:::terraform-dev-env-state/*",
        "arn:aws:s3:::terraform-dev-env-state"
      ]
    }
  ]
}
EOF
}

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
    store-terraform-state-file-in-bucket = "arn:aws:iam::182021176759:policy/store-terraform-state-file-in-bucket"
  }

  tags = {
    Environment = var.environment_name
  }
}