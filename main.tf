variable "parameter_read" {
  default = []
}

variable "parameter_write" {
  description = "List of maps"
  default     = []

  /*
# Parameter Write Format Example
# description, tags, and overwrite are optional
[{
  name = "/${var.namespace}/${var.stage}/${var.name}/database/master_password"
  # Valid types are String, StringList and SecureString
  type = "SecureString"
  value = "${var.master_password}"
  description = "Database master password"
  overwrite = false 
}]
*/
}

variable "tags" {
  type    = "map"
  default = {}
}

variable "kms_arn" {
  type    = "string"
  default = ""
}

data "aws_ssm_parameter" "read" {
  count = "${length(var.parameter_read)}"
  name  = "${element(var.parameter_read, count.index)}"
}

resource "aws_ssm_parameter" "default" {
  count           = "${length(var.parameter_write)}"
  name            = "${lookup(var.parameter_write[count.index], "name")}"
  description     = "${lookup(var.parameter_write[count.index], "description", lookup(var.parameter_write[count.index], "name"))}"
  type            = "${lookup(var.parameter_write[count.index], "type", "SecureString")}"
  key_id          = "${lookup(var.parameter_write[count.index], "type", "SecureString") == "SecureString" && length(var.kms_arn) > 0 ? var.kms_arn : ""}"
  value           = "${lookup(var.parameter_write[count.index], "value")}"
  overwrite       = "${lookup(var.parameter_write[count.index], "overwrite", "false")}"
  allowed_pattern = "${lookup(var.parameter_write[count.index], "allowed_pattern", "")}"
  tags            = "${var.tags}"
}

locals {
  name_list  = "${compact(concat(split("~^~",join("~^~", aws_ssm_parameter.default.*.name)), split("~^~",join("~^~", data.aws_ssm_parameter.read.*.name))))}"
  value_list = "${compact(concat(split("~^~",join("~^~", aws_ssm_parameter.default.*.value)), split("~^~",join("~^~", data.aws_ssm_parameter.read.*.value))))}"
}

output "names" {
  value = "${local.name_list}"
}

output "values" {
  value = "${local.value_list}"
}

output "map" {
  value = "${zipmap(local.name_list, local.value_list)}"
}
