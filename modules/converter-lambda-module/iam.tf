resource "aws_iam_policy" "s3_policy" {
  name        = "${var.function_name}S3Policy"
  description = var.iam_policy_description

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = var.s3_allow_actions
        Resource = var.resource_arns
      }
    ]
  })
}


resource "aws_iam_role" "lambda_role" {
  name = "${var.function_name}Role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "mkeloDataAnalysisBasicExecutionRole" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}


resource "aws_iam_role_policy_attachment" "mkeloDataAnalysisPolicyAttachment" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.s3_policy.arn
}
