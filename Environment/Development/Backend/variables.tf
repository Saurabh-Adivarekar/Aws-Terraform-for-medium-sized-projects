# region
variable "region" {
  type = string
}

# ecs variables
variable "cluster_name" {
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

variable "service_name" {
  type = string
}

variable "service_asg_max_capacity" {
  type = number
}

variable "service_asg_min_capacity" {
  type = number
}

variable "service_asg_target_tracking_value" {
  type = number
}
# compute
variable "key_name" {
  type = string
}

variable "ecs_ec2_tag" {
  type = string
}

variable "launch_template_name" {
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

#ecr
variable "ecr_repo_name" {
  type = string
}

#vpc



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

variable "tags" {
  type = map(string)
  default = {}
}

variable "public_route_table_tag" {
  type = string
}

variable "ig_tag" {
  
}

#codebuild

variable "codebuild_iam_role_name_frontend" {
  type    = string
  default = ""
}

variable "codebuild_project_name_frontend" {
  type    = string
  default = ""
}

variable "codebuild_environment_compute_type" {
  type    = string
  default = ""
}

variable "codebuild_environment_variable_frontend" {
  type    = any
  default = {}
}

variable "codebuild_source" {
  type    = any
  default = {}
}

variable "codebuild_vpc_config" {
  type    = any
  default = {}
}

variable "codebuild_iam_role_name_backend" {
  type    = string
  default = ""
}

variable "codebuild_project_name_backend" {
  type    = string
  default = ""
}

variable "codebuild_environment_variable_backend" {
  type    = any
  default = {}
}


#codepipeline_fe

variable "codestar_arn" {
  type = string
}

variable "codestar_provider_type_fe" {
  type = string
}

variable "codepipeline_bucket_name_fe" {
  type = string
}

variable "codepipeline_role_name_fe" {
  type = string
}

variable "codepipeline_policy_name_fe" {
  type = string
}

variable "codepipeline_name_fe" {
  type = string
}

variable "FullRepositoryId_fe" {
  type = string
}

variable "BranchName_fe" {
  type = string
}

#codepipeline_be

variable "codestar_provider_type_be" {
  type = string
}

variable "codepipeline_bucket_name_be" {
  type = string
}

variable "codepipeline_role_name_be" {
  type = string
}

variable "codepipeline_policy_name_be" {
  type = string
}

variable "codepipeline_name_be" {
  type = string
}

variable "FullRepositoryId_be" {
  type = string
}

variable "BranchName_be" {
  type = string
}

variable "account_id" {
  type = number
}