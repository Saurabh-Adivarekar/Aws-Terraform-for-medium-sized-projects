## Variables

variable "tags" {
  type    = map(string)
  default = {}
}

variable "bucket_name" {
  type    = string
  default = ""
}

variable "cors_rule" {
  type    = any
  default = {}
}

variable "bucket_policy" {
  type    = string
  default = ""
}
