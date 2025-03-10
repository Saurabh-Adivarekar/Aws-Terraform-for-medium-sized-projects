variable "vpc_name" {
  type = string
}

variable "cidr_subnets" {
  type = list(string)
}

variable "az" {
  type = list(string)
}

variable "cidr_block" {
  type = string
  default = ""
}

variable "instance_tenancy" {
  type = string
}

variable "ig_tag" {
  type = string
}

variable "public_route_table_tag" {
  type = string
}
