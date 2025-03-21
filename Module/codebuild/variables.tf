## Variables

variable "codebuild_project_name" {
  type    = string
  default = ""
}

variable "codebuild_project_description" {
  type    = string
  default = "CodeBuild Project for Infra"
}

variable "environment_compute_type" {
  type    = string
  default = ""
}

variable "environment_variable" {
  type    = any
  default = {}
}

variable "codebuild_source" {
  type    = any
  default = {}
}

variable "vpc_config" {
  type    = any
  default = {}
}

variable "codebuild_iam_role_name" {
  type    = string
  default = ""
}

variable "codebuild_iam_role_assume_role_policy" {
  type    = any
  default = ""
}

variable "codebuild_iam_role_policy" {
  type    = any
  default = ""
}

variable "tags" {
  type    = map(string)
  default = {}
}
