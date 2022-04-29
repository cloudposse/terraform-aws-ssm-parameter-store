locals {
  enabled = module.this.enabled

  parameter_write = local.enabled ? {
    for e in var.parameter_write :
    e.name => merge(var.parameter_write_defaults, e)
    if e != {}
  } : {}

  parameter_read = local.enabled ? var.parameter_read : []
}

data "aws_ssm_parameter" "read" {
  count = length(local.parameter_read)
  name  = element(local.parameter_read, count.index)
}

resource "aws_ssm_parameter" "default" {
  for_each = ! var.ignore_value_changes ? local.parameter_write : {}
  name     = each.key

  description     = each.value.description
  type            = each.value.type
  tier            = each.value.tier
  key_id          = each.value.type == "SecureString" && length(var.kms_arn) > 0 ? var.kms_arn : ""
  value           = each.value.value
  overwrite       = each.value.overwrite
  allowed_pattern = each.value.allowed_pattern
  data_type       = each.value.data_type

  tags = module.this.tags
}

resource "aws_ssm_parameter" "ignore_value_changes" {
  for_each = var.ignore_value_changes ? local.parameter_write : {}
  name     = each.key

  description     = each.value.description
  type            = each.value.type
  tier            = each.value.tier
  key_id          = each.value.type == "SecureString" && length(var.kms_arn) > 0 ? var.kms_arn : ""
  value           = each.value.value
  overwrite       = each.value.overwrite
  allowed_pattern = each.value.allowed_pattern
  data_type       = each.value.data_type

  tags = module.this.tags

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}
