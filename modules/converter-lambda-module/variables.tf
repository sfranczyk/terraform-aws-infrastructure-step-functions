variable "function_name" {
  type = string
}

variable "iam_policy_description" {
  type        = string
  description = "Description of the IAM policy"
}

variable "s3_allow_actions" {
  type    = list(string)
  default = ["s3:GetObject", "s3:PutObject"]
}

variable "resource_arns" {
  type    = list(string)
}
