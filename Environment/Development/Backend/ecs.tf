module "ecs" {
  source = "../../../Module/ecs"

  account_id                        = var.account_id
  region                            = var.region
  cluster_name                      = var.cluster_name
  capacity_provider_name            = var.capacity_provider_name
  aws_cloudwatch_log_group_name     = var.aws_cloudwatch_log_group_name
  ecs_task_definition_name          = var.ecs_task_definition_name
  container_name                    = var.container_name
  image_name                        = module.ecr_module.output_ecr_repo_url
  service_name                      = var.service_name
  ecs_auto_scaling_group_arn        = module.compute.output_ecs_autoscaling_group_arn
  target_group_arn                  = module.compute.output_target_group_arn
  ecs_auto_scaling_group_name       = module.compute.output_ecs_auto_scaling_group_name
  task_cpu                          = var.task_cpu
  task_memory                       = var.task_memory
  containerport                     = var.containerport
  hostport                          = var.hostport
  service_desired_count             = var.service_desired_count
  service_asg_max_capcacity         = var.service_asg_max_capacity
  service_asg_min_capcacity         = var.service_asg_min_capacity
  service_asg_target_tracking_value = var.service_asg_target_tracking_value
}
