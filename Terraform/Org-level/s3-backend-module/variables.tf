variable "bucket_name" {
  description = "Name of the S3 bucket to be created."
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