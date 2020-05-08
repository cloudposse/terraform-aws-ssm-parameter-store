provider "aws" {
  region = var.region
}

module "kms_key" {
  source                  = "git::https://github.com/cloudposse/terraform-aws-kms-key.git?ref=tags/0.4.0"
  namespace               = var.namespace
  stage                   = var.stage
  name                    = var.namespace
  description             = "terraform-aws-ssm-parameter-store test KMS key"
  deletion_window_in_days = 10
  enable_key_rotation     = true
  alias                   = "alias/parameter_store_key"
  tags                    = var.tags
}

module "store" {
  source          = "../../"
  parameter_write = var.parameter_write
  kms_arn         = module.kms_key.key_arn
  tags            = var.tags
}
