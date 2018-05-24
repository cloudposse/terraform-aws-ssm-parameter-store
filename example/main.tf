variable "namespace" {
  default = "default"
}

variable "tags" {
  type    = "map"
  default = {}
}

variable "parameter_write" {
  default = []
  type    = "list"
}

variable "parameter_read" {
  type    = "list"
  default = []
}

provider "aws" {
  region = "eu-west-2"

  # Make it faster by skipping something
  skip_get_ec2_platforms      = true
  skip_metadata_api_check     = true
  skip_region_validation      = true
  skip_credentials_validation = true
  skip_requesting_account_id  = true
}

module "kms_key" {
  source                  = "git::https://github.com/cloudposse/terraform-aws-kms-key.git?ref=master"
  namespace               = "${var.namespace}"
  stage                   = "prod"
  name                    = "key"
  tags                    = "${var.tags}"
  description             = "KMS key for chamber"
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

output "parameter_names" {
  description = "List of key names"
  value       = "${module.store.names}"
}

output "parameter_values" {
  description = "List of values"
  value       = "${module.store.values}"
}

output "map" {
  description = "Map of parameters"
  value       = "${module.store.map}"
}
