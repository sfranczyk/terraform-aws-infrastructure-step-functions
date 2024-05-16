variable "convert_sql_to_csv_lambda_arn" {
    description = "ARN of the convert SQL to CSV Lambda function"
    type        = string
}

variable "analyse_data_time_lambda_arn" {
    description = "ARN of the analyse data time Lambda function"
    type        = string
}

variable "s3_bucket_arn" {
    description = "ARN of the bucket"
    type        = string
}

variable "s3_bucket_name" {
    description = "Name of the bucket"
    type        = string
}

variable "data_object_key" {
    description = "Key of the data object"
    type        = string
}

variable "sqs_queue_url" {
    type        = string
    description = "ARN of the SQS queue"
}

variable "sqs_queue_arn" {
    type        = string
    description = "ARN of the SQS queue"
}