variable "region" {
  type        = string
  description = "AWS Region"
}

variable "parameter_write" {
  type        = list(map(string))
  description = "List of maps with the parameter values to write to SSM Parameter Store"
}

variable "parameter_read" {
  type        = list(string)
  description = "List of parameters to read from SSM. These must already exist otherwise an error is returned. Can be used with `parameter_write` as long as the parameters are different."
  default     = []
}
