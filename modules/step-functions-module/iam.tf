resource "aws_iam_role" "step_functions_role" {
  name               = "StepFunctionsRole"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "states.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy" "invoke_lambda" {
  name   = "InvokeLambdaPolicy"
  role   = aws_iam_role.step_functions_role.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "lambda:InvokeFunction"
        ]
        Resource = [
          "${var.convert_sql_to_csv_lambda_arn}:*",
          "${var.analyse_data_time_lambda_arn}:*",
          "${var.convert_sql_to_csv_lambda_arn}",
          "${var.analyse_data_time_lambda_arn}"
        ]
      },
    ]
  })
}

resource "aws_iam_role_policy" "sqs_send_message" {
  name   = "SqsSendMessagePolicy"
  role   = aws_iam_role.step_functions_role.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "sqs:SendMessage"
        ]
        Resource = [
          var.sqs_queue_arn
        ]
      },
    ]
  })
}

resource "aws_iam_role_policy" "s3_access" {
  name   = "S3AccessPolicy"
  role   = aws_iam_role.step_functions_role.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject"
        ]
        Resource = "${var.s3_bucket_arn}/cleaned_data.csv"
      },
      {
        Effect = "Allow"
        Action = [
          "s3:PutObject",
          "s3:GetObject",
          "s3:ListMultipartUploadParts",
          "s3:AbortMultipartUpload"
        ]
        Resource = "${var.s3_bucket_arn}/output1/*"
      },
    ]
  })
}

resource "aws_iam_role_policy" "step_functions_actions" {
  name   = "StepFunctionsActionsPolicy"
  role   = aws_iam_role.step_functions_role.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "states:StartExecution",
          "states:DescribeExecution",
          "states:StopExecution"
        ]
        Resource = aws_sfn_state_machine.sfn_state_machine.arn
      }
    ]
  })
}

resource "aws_iam_role_policy" "xray_access" {
  name   = "XRayAccessPolicy"
  role   = aws_iam_role.step_functions_role.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "xray:PutTraceSegments",
          "xray:PutTelemetryRecords",
          "xray:GetSamplingRules",
          "xray:GetSamplingTargets"
        ]
        Resource = "*"
      },
    ]
  })
}