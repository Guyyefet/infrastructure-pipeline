module "github_oidc_provider" {
  source    = "terraform-aws-modules/iam/aws//modules/iam-github-oidc-provider"
  version = " 5.27.0"

  client_id_list = ["sts.amazonaws.com"]
}

module "terraform-plan-role" {
  source    = "terraform-aws-modules/iam/aws//modules/iam-github-oidc-role"
  version = " 5.27.0"

  # for_each = toset(var.environments)

  name = "terraform-plan-role"
  
  subjects = ["terraform-aws-modules/terraform-aws-iam:*",
              "Guyyefet/infrastructure-pipeline:*"]

  policies = {
    store-terraform-state-file-in-bucket-development = module.store-terraform-state-file-in-bucket["development"].arn,
    store-terraform-state-file-in-bucket-testing = module.store-terraform-state-file-in-bucket["testing"].arn,
    EC2_FULL_ACCESS = "arn:aws:iam::182021176759:policy/EC2_FULL_ACCESS",
    dynamoDB-state-locks-development = module.dynamoDB-state-locks["development"].arn,
    dynamoDB-state-locks-testing = module.dynamoDB-state-locks["testing"].arn,
    # dev-env-vpc-premisions = module.dev-env-vpc-premisions.arn,
    iam-permissions-to-assume-role = module.iam-permissions-to-assume-role.arn

  }
}

module "my-user" {
  source = "terraform-aws-modules/iam/aws//modules/iam-user"
  version   = "5.27.0"

  name = "infrastructre-pipeline-user"
}

# module "admin-group" {
#   source = "terraform-aws-modules/iam/aws//modules/iam-group-with-policies"
#   version   = "5.27.0" 

#   name = "admins"

#   group_users = ["${module.my-user.iam_user_arn}"]
#   custom_group_policy_arns = []
# }


module "store-terraform-state-file-in-bucket" {
  source    = "terraform-aws-modules/iam/aws//modules/iam-policy"
  version   = "5.27.0"

  for_each = toset(var.environments)

  name = "store-terraform-state-file-in-bucket-${each.value}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:ListBucket",
        "s3:ListBucketMultipartUploads",
        "s3:GetBucketLocation",
        "s3:GetBucketVersioning",
        "s3:GetBucketEncryption"
      ],
      "Resource": "${module.environments_backend[each.key].s3_bucket_arn}"
    },
    {
      "Effect": "Allow",
      "Action": [
        "s3:GetObject",
        "s3:PutObject",
        "s3:DeleteObject",
        "s3:AbortMultipartUpload",
        "s3:ListMultipartUploadParts",
        "s3:PutBucketVersioning",
        "s3:PutBucketEncryption"
      ],
      "Resource": [
        "${module.environments_backend[each.key].s3_bucket_arn}/*",
        "${module.environments_backend[each.key].s3_bucket_arn}"
      ]
    }
  ]
}
EOF
}


module "dynamoDB-state-locks" {
  source    = "terraform-aws-modules/iam/aws//modules/iam-policy"
  version = " 5.27.0"

  for_each = toset(var.environments)

  name = "dynamoDB-state-locks-${each.value}"

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
                "dynamodb:DeleteItem",
                "dynamodb:DescribeContinuousBackups"
            ],
            "Resource": "${module.environments_backend[each.key].table_arn}"
        }
    ]
}
EOF
}

module "iam-permissions-to-assume-role" {
  source    = "terraform-aws-modules/iam/aws//modules/iam-policy"
  version = " 5.27.0"

  # for_each = toset(var.environments)

  name = "iam-permissions-to-assume-role"

   policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "iam:GetRole",
                "iam:PassRole",
                "iam:CreateRole",
                "iam:DeleteRole",
                "iam:CreatePolicy",
                "iam:DeletePolicy",
                "iam:GetPolicy",
                "iam:AttachRolePolicy",
                "iam:DetachRolePolicy",
                "iam:PutRolePolicy",
                "iam:DeleteRolePolicy"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}

# module "env-vpc-premisions" {
#   source    = "terraform-aws-modules/iam/aws//modules/iam-policy"
#   version = " 5.27.0"

#   for_each = toset(var.environments)

#   name = "${each.value}-env-vpc-premisions"

#    policy = <<EOF
# {
#     "Version": "2012-10-17",
#     "Statement": [
#         {
#             "Effect": "Allow",
#             "Action": [
#                 "ec2:AssociateRouteTable",
#                 "ec2:AssociateSubnetCidrBlock",
#                 "ec2:AssociateVpcCidrBlock",
#                 "ec2:CreateRoute",
#                 "ec2:CreateRouteTable",
#                 "ec2:CreateSecurityGroup",
#                 "ec2:CreateSubnet",
#                 "ec2:CreateTags",
#                 "ec2:CreateVpc",
#                 "ec2:DeleteRoute",
#                 "ec2:DeleteRouteTable",
#                 "ec2:DeleteSecurityGroup",
#                 "ec2:DeleteSubnet",
#                 "ec2:DeleteTags",
#                 "ec2:DeleteVpc"
#             ],
#             "Resource": "*"
#         }
#     ]
# }
# EOF
# }
