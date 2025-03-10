# Variables

variable "tags" {
  type    = map(string)
  default = {}
}

variable "default_cache_behavior" {
  type    = any
  default = {}
}

variable "custom_error_response" {
  type    = any
  default = {}
}

variable "origin" {
  type    = any
  default = {}
}

variable "aliases" {
  type    = list(string)
  default = [""]
}

variable "s3_origin_name" {
  type    = string
  default = ""
}
