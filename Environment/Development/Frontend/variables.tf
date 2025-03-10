variable "region" {
  type    = string
  default = ""
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "s3_bucket_name" {
  type    = string
  default = ""
}

variable "s3_cors_rule" {
  type    = any
  default = {}
}

variable "s3_bucket_policy" {
  type    = string
  default = ""
}

variable "cloudfront_default_cache_behavior" {
  type    = any
  default = {}
}

variable "cloudfront_custom_error_response" {
  type    = any
  default = {}
}

variable "cloudfront_origin" {
  type    = any
  default = {}
}

variable "cloudfront_aliases" {
  type    = list(string)
  default = [""]
}

variable "cloudfront_s3_origin_name" {
  type    = string
  default = ""
}
