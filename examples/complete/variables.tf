variable "region" {
  type        = string
  description = "AWS Region"
}

variable "parameter_write" {
  type        = list(map(string))
  description = "List of maps with the parameter values to write to SSM Parameter Store"
}
