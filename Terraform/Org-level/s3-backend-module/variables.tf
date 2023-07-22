variable "bucket_name" {
  description = "the bucket's name"
  default     = ""
  type        = string
}

variable "bucket_versioning" {
  description = "the bucket versioning status"
  default = "Enabled"
  type = string
}

variable "dynamodb_table" {
  description = "the dynamodb table for state-locks"
  default = ""
  type = string
}

variable "default_policy_actions" {
  description = "the default policy actions of the bucket"
  default = [
        "s3:GetObject",
        "s3:PutObject",
        "s3:ListBucket"
      ]
  type = list(string)
}

variable "policy_principal_identifiers" {
  description = "the policy's principal identifiers of the bucket"
  default = []
  type = list(string)
}











