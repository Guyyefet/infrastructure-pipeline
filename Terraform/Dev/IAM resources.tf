module "store-terraform-state-file-in-bucket" {
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

module "dynamoDB-state-locks" {
  source    = "../.terraform/modules/iam_github_oidc_provider/modules/iam-policy"

  name = "dynamoDB-state-locks"

   policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "dynamodb:DescribeTable",
                "dynamodb:GetItem",
                "dynamodb:PutItem",
                "dynamodb:DeleteItem"
            ],
            "Resource": "arn:aws:dynamodb:::table/terraform-dev-env-locks"
        }
    ]
}
EOF
}

module "dev-env-vpc-premisions" {
  source    = "../.terraform/modules/iam_github_oidc_provider/modules/iam-policy"

  name = "dev-env-vpc-premisions"

   policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ec2:AssociateRouteTable",
                "ec2:AssociateSubnetCidrBlock",
                "ec2:AssociateVpcCidrBlock",
                "ec2:CreateRoute",
                "ec2:CreateRouteTable",
                "ec2:CreateSecurityGroup",
                "ec2:CreateSubnet",
                "ec2:CreateTags",
                "ec2:CreateVpc",
                "ec2:DeleteRoute",
                "ec2:DeleteRouteTable",
                "ec2:DeleteSecurityGroup",
                "ec2:DeleteSubnet",
                "ec2:DeleteTags",
                "ec2:DeleteVpc"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}

module "iam_github_oidc_provider_for_terraform_plan_role" {
  source    = "../.terraform/modules/iam_github_oidc_provider/modules/iam-github-oidc-provider"

  client_id_list = ["sts.amazonaws.com"]

  tags = {
    Environment = var.environment_name
  }
}

module "terraform-plan-role" {
  source    = "../.terraform/modules/iam_github_oidc_role/modules/iam-github-oidc-role"

  name = "terraform-plan-role"
  
  subjects = ["terraform-aws-modules/terraform-aws-iam:*",
              "Guyyefet/infrastructure-pipeline:Terraform/Dev:*"]

  policies = {
    store-terraform-state-file-in-bucket = module.store-terraform-state-file-in-bucket.arn,
    EC2_FULL_ACCESS = "arn:aws:iam::182021176759:policy/EC2_FULL_ACCESS",
    dev-env-vpc-premisions = module.dev-env-vpc-premisions.arn
    dynamoDB-state-locks = module.dynamoDB-state-locks.arn
  }

  tags = {
    Environment = var.environment_name
    random = "test"
  }
}