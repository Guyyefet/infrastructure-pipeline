output "s3_bucket_id" {
  description = "The name of the bucket"
  value       =  try(aws_s3_bucket.this.id, null)
}

output "s3_bucket_arn" {
  description = ""
  value = try(aws_s3_bucket.this.arn, null)
}

output "table_arn" {
  description = ""
  value = try(aws_dynamodb_table.this.arn, null)
}