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
