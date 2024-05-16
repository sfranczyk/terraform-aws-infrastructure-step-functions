output "queue_url" {
  value       = aws_sqs_queue.data_analysis_queue.url
  description = "The URL of the SQS queue"
}

output "queue_arn" {
  value       = aws_sqs_queue.data_analysis_queue.arn
  description = "The ARN of the SQS queue"
}