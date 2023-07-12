output "s3_bucket_id" {
  description = "The name of the bucket."
  value       =  try(aws_s3_bucket.this[0].id, null)
}

output "s3_bucket_arn" {
  description = ""
  value = try(aws_s3_bucket.this[0].arn, null)
}