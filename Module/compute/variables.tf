variable "key_name" {
  type = string
}

variable "launch_template_name" {
  type = string
}

variable "ecs_ec2_tag" {
  type = string
}

variable "asg_name" {
  type = string
}

variable "ecs_ec2_sg_name" {
  type = string
}

variable "ecs_alb_sg_name" {
  type = string
}

variable "lb_protocol" {
  type = string
}

variable "ecs_alb_name" {
  type = string
}

variable "ecs_tg_name" {
  type = string
}

variable "ingress_ec2_sg_rule" {
  type    = any
  default = {}
}

variable "egress_ec2_sg_rule" {
  type    = any
  default = {}
}

variable "ingress_alb_sg_rule" {
  type = any
}

variable "egress_alb_sg_rule" {
  type = any
}

variable "image_id" {
  type = any
}

variable "instance_type" {
  type = string
}

variable "asg_desired_capacity" {
  type = number
}

variable "asg_max_size" {
  type = number
}

variable "asg_min_size" {
  type = number
}

variable "subnet1_id" {
  type = string
}

variable "subnet2_id" {
  type = string
}

variable "vpc_id" {
  type = string
}