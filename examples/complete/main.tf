module "kms_key" {
  source    = "git::https://github.com/cloudposse/terraform-aws-kms-key.git?ref=master"
  namespace = "cp"
  stage     = "prod"
  name      = "app"

  tags = {
    ManagedBy = "Terraform"
  }

  description             = "KMS key for Parameter Store"
  deletion_window_in_days = 10
  enable_key_rotation     = "true"
  alias                   = "alias/parameter_store_key"
}

module "store" {
  source = "../"

  tags = {
    ManagedBy = "Terraform"
  }

  parameter_write = [
    {
      name      = "/production/test/master/users"
      value     = "John,Todd"
      type      = "StringList"
      overwrite = "true"
    },
    {
      name      = "/production/test/master/password"
      value     = "somepassword"
      type      = "SecureString"
      overwrite = "true"
    },
    {
      name        = "/production/test/master/company"
      value       = "Amazon"
      type        = "String"
      overwrite   = "true"
      description = "Company name"
    },
  ]

  kms_arn = module.kms_key.key_arn
}
