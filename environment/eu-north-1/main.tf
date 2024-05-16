module "s3_bucket_module" {
  source      = "../../modules/s3-module"
  bucket_name = "mkelo-data-analysis2"
}

module "converter_lambda_module" {
  source                = "../../modules/converter-lambda-module"
  iam_policy_description = "Policy for converter lambda"
  function_name         = "ConvertSqlToCSV2"
  s3_allow_actions = ["s3:GetObject", "s3:PutObject", "s3:DeleteObject"]
  resource_arns = ["${module.s3_bucket_module.bucket_arn}/*"]
}

module "analyse_data_time_lambda_module" {
  source                = "../../modules/analyse-data-time-lambda-module"
  function_name         = "AnalyseDataTime2"
}

module "sqs_queue_module" {
  source      = "../../modules/sqs-module"
  queue_name  = "MkeloDataAnalysisQueue2"
}

module "step_functions_module" {
  source = "../../modules/step-functions-module"
  analyse_data_time_lambda_arn = module.analyse_data_time_lambda_module.invoke_arn
  convert_sql_to_csv_lambda_arn = module.converter_lambda_module.invoke_arn
  s3_bucket_name = module.s3_bucket_module.bucket_name
  s3_bucket_arn = module.s3_bucket_module.bucket_arn
  data_object_key = "cleaned_data.csv"
  sqs_queue_url = module.sqs_queue_module.queue_url
  sqs_queue_arn = module.sqs_queue_module.queue_arn
}