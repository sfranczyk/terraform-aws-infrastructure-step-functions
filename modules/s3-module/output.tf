output "bucket_arn" {
  value       = aws_s3_bucket.data_analysis_bucket.arn
  description = "The ARN of the S3 bucket"
}

output "bucket_name" {
  value       = aws_s3_bucket.data_analysis_bucket.bucket
  description = "The name of the S3 bucket"
}