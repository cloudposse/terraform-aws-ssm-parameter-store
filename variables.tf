variable "parameter_read" {
  description = <<DESC
  A list of parameters to read. These must already exist otherwise an error is given."
  Can be used with `parameter_write` as long as the parameters are different.
DESC

  default = []
}

variable "parameter_write" {
  description = <<DESC
  List of Maps with the Parameter values in this format.
  Parameter Write Format Example

  [{
    name = "/${var.namespace}/${var.stage}/${var.name}/database/master_password" // Required
    type = "SecureString" // Required - Valid types are String, StringList and SecureString
    value = "${var.master_password}" // Required
    description = "Database master password" // Optional
    overwrite = false // Optional - Force Overwrite of value if true. 
  }]
DESC

  default = []
}

variable "tags" {
  type        = "map"
  default     = {}
  description = "A map containing tags that will be added to the parameter"
}

variable "kms_arn" {
  type        = "string"
  default     = ""
  description = "The ARN of a KMS key used to encrypt and decrypt SecretString values"
}

variable "enabled" {
  type        = "string"
  default     = "true"
  description = "When 'true' the resources and data will be created."
}

variable "split_delimiter" {
  type        = "string"
  default     = "~^~"
  description = "A delimiter for splitting and joining lists together for normalising the output"
}
