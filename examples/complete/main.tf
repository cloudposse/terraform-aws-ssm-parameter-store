provider "aws" {
  region = var.region
}

module "kms_key" {
  source                  = "cloudposse/kms-key/aws"
  version                 = "0.9.0"
  description             = "terraform-aws-ssm-parameter-store test KMS key"
  deletion_window_in_days = 10
  enable_key_rotation     = true
  alias                   = "alias/parameter_store_key"

  context = module.this.context
}

module "store" {
  source          = "../../"
  parameter_write = var.parameter_write
  kms_arn         = module.kms_key.key_arn

  context = module.this.context
}
