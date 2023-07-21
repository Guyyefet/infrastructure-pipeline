variable "bucket_name" {
  description = "Name of the S3 bucket to be created"
  default     = ""
  type        = string
}

variable "bucket_versioning" {
  description = "value"
  default = "Enabled"
  type = string
}

variable "dynamodb_table" {
  description = "dynamodb table for state-locks"
  default = ""
  type = string
}

variable "default_policy_actions" {
  description = "the default actions of the policy"
  default = [
        "s3:GetObject",
        "s3:PutObject",
        "s3:ListBucket"
      ]
  type = list(string)
}

variable "identifiers" {
  description = "value"
  default = []
  type = list(string)
}











