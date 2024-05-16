resource "aws_sfn_state_machine" "sfn_state_machine" {
  name     = "MkeloStateMachine-1234567890"
  role_arn = aws_iam_role.step_functions_role.arn
  definition = templatefile("${path.module}/statemachine.asl.json", {
        ConvertSqlToCsvLambdaArn = var.convert_sql_to_csv_lambda_arn,
        AnalyseDataTimeLambdaArn = var.analyse_data_time_lambda_arn,
        DataAnalysisQueueUrl = var.sqs_queue_url,
        BucketName = var.s3_bucket_name,
        DataObjectKey = var.data_object_key
    }
  )
}