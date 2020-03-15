variable "parameter_read" {
  type        = list
  description = "List of parameters to read from SSM. These must already exist otherwise an error is returned. Can be used with `parameter_write` as long as the parameters are different."
  default     = []
}

variable "parameter_write" {
  type = list

  description = <<DESC
  List of maps with the Parameter values in this format.
  Parameter Write Format Example

  [{
    name = "/cp/prod/app/database/master_password" // Required
    type = "SecureString" // Required - Valid types are String, StringList and SecureString
    value = "password1" // Required
    description = "Production database master password" // Optional
    overwrite = false // Optional - Force Overwrite of value if true. 
  }]
DESC

  default = []
}

variable "tags" {
  type        = map
  default     = {}
  description = "Map containing tags that will be added to the parameters"
}

variable "kms_arn" {
  type        = string
  default     = ""
  description = "The ARN of a KMS key used to encrypt and decrypt SecretString values"
}

variable "enabled" {
  type        = string
  default     = "true"
  description = "Set to `false` to prevent the module from creating and accessing any resources"
}

variable "split_delimiter" {
  type        = string
  default     = "~^~"
  description = "A delimiter for splitting and joining lists together for normalising the output"
}
