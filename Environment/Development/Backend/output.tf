output "ecs_alb_dns_name" {
  value = module.compute.output_alb_dns
}

output "ecr_repository_url" {
  value = module.ecr_module.output_ecr_repo_url
}

output "ecs_cluster_name" {
  value = var.cluster_name
}

output "ecs_service_name" {
  value = var.service_name
}