provider "aws" {
  region = var.region
}

module "kms_key" {
  source                  = "cloudposse/kms-key/aws"
  version                 = "0.11.0"
  description             = "terraform-aws-ssm-parameter-store test KMS key"
  deletion_window_in_days = 10
  enable_key_rotation     = true
  alias                   = "alias/parameter_store_key"

  context = module.this.context
}

module "store" {
  source          = "../../"
  parameter_write = var.parameter_write
  parameter_read  = var.parameter_read
  kms_arn         = module.kms_key.key_arn

  context = module.this.context

  depends_on = [
    aws_ssm_parameter.preexisting_parameter
  ]
}

# This resource is used to test var.parameter_read in both enabled and disabled contexts.
# The value is hardcoded because it is referenced in examples_complete_test.go
resource "aws_ssm_parameter" "preexisting_parameter" {
  count = length(var.parameter_read)
  name  = element(var.parameter_read, count.index)
  type  = "SecureString"
  value = "preexisting_value"
}