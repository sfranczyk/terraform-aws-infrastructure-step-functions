data "archive_file" "archive_code_file" {
  type        = "zip"
  source_dir  = "${path.module}/source"
  output_path = "${path.module}/source/archive.zip"
}

resource "aws_lambda_function" "lambda_function" {
  depends_on = [ data.archive_file.archive_code_file ]
  function_name = var.function_name
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.12"
  role          = aws_iam_role.lambda_role.arn
  filename      = data.archive_file.archive_code_file.output_path
}