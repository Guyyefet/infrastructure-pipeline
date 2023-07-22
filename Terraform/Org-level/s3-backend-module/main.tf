terraform {
  required_version = ">=0.12"
}

locals {
  root_account_id = ["${data.aws_caller_identity.current.account_id}"]
}

data "aws_caller_identity" "current" {}

resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name

  lifecycle {
    prevent_destroy = false
  }
}

resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.this.id
  versioning_configuration {
    status = var.bucket_versioning
  }

  lifecycle {
    prevent_destroy = false
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "default" {
  bucket = aws_s3_bucket.this.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_policy" "this" {
  bucket = aws_s3_bucket.this.id

  policy = <<-EOF
   {
   	"Version": "2012-10-17",
   	"Statement": [{
   		"Effect": "Allow",
   		"Principal": {
        "AWS": ${jsonencode(var.policy_principal_identifiers != [] ? var.policy_principal_identifiers : local.root_account_id)}
        },
   		"Action": ${jsonencode(var.default_policy_actions)}
,
   		"Resource": [
   			"${aws_s3_bucket.this.arn}",
   			"${aws_s3_bucket.this.arn}/*"
   		]
   	}]
   }   
EOF
}

resource "aws_dynamodb_table" "this" {
  name         = var.dynamodb_table
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }

  lifecycle {
    prevent_destroy = false
  }
}