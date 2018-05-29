module "kms_key" {
  source                  = "git::https://github.com/cloudposse/terraform-aws-kms-key.git?ref=master"
  namespace               = "${var.namespace}"
  stage                   = "prod"
  name                    = "key"
  tags                    = "${var.tags}"
  description             = "KMS key for Parameter Store"
  deletion_window_in_days = 10
  enable_key_rotation     = "true"
  alias                   = "alias/parameter_store_key"
}

module "store" {
  source          = "../"
  parameter_write = "${var.parameter_write}"
  parameter_read  = "${var.parameter_read}"

  tags    = "${var.tags}"
  kms_arn = "${module.kms_key.key_arn}"
}
