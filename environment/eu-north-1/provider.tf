provider "aws" {
  region  = "eu-north-1"

  default_tags {
    tags = {
      "TerraformTraining" = "true"
    }
  }
}