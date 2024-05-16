resource "aws_sqs_queue" "data_analysis_queue" {
  name                        = var.queue_name
  max_message_size            = 262144
  message_retention_seconds   = 86400
  visibility_timeout_seconds  = 30
}