variable "region" {
  type = string
}


variable "cluster_name" {
  type = string
}

variable "ecs_auto_scaling_group_arn" {
  type = string
}

variable "target_group_arn" {
  type = string
}

variable "ecs_auto_scaling_group_name" {
  type = string
}

variable "task_cpu" {
  type = number
}

variable "task_memory" {
  type = number
}

variable "containerport" {
  type = number
}

variable "hostport" {
  type = number
}

variable "service_desired_count" {
  type = number
}

variable "capacity_provider_name" {
  type = string
}

variable "aws_cloudwatch_log_group_name" {
  type = string
}

variable "ecs_task_definition_name" {
  type = string
}

variable "container_name" {
  type = string
}

variable "image_name" {
  type = string
}

variable "service_name" {
  type = string
}

variable "service_asg_max_capcacity" {
  type = number
}

variable "service_asg_min_capcacity" {
  type = number
}

variable "service_asg_target_tracking_value" {
  type = number
}

variable "account_id" {
  type = number
}