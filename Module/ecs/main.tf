# ecs cluster
resource "aws_ecs_cluster" "ecs_cluster" {
  name = var.cluster_name

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}


# Capacity provider
resource "aws_ecs_capacity_provider" "ecs_capacity_provider" {
  name = var.capacity_provider_name

  auto_scaling_group_provider {
    auto_scaling_group_arn = var.ecs_auto_scaling_group_arn

    managed_scaling {
      maximum_scaling_step_size = 1000
      minimum_scaling_step_size = 1
      status                    = "ENABLED"
      target_capacity           = 1
    }
  }
}


resource "aws_ecs_cluster_capacity_providers" "ecluster_cp" {
  cluster_name = aws_ecs_cluster.ecs_cluster.name

  capacity_providers = [aws_ecs_capacity_provider.ecs_capacity_provider.name]

  default_capacity_provider_strategy {
    base              = 1
    weight            = 100
    capacity_provider = aws_ecs_capacity_provider.ecs_capacity_provider.name
  }
}


# Cloudwatch group
resource "aws_cloudwatch_log_group" "log_group" {
  name              = var.aws_cloudwatch_log_group_name 
  retention_in_days = "90"
}


# Task Definition
resource "aws_ecs_task_definition" "ecs_task_definition" {
  family                   = var.ecs_task_definition_name 
  execution_role_arn       = "arn:aws:iam::${var.account_id}:role/ecsTaskExecutionRole"   
  requires_compatibilities = ["EC2"]

  cpu                = var.task_cpu       
  memory             = var.task_memory       

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }

  container_definitions = jsonencode([
    {
      name      = var.container_name
      image     = var.image_name 
      essential = true
      portMappings = [
        {
          containerPort = var.containerport
          hostPort      = var.hostport
        }
      ]
      logConfiguration = {
        logDriver = "awslogs",
        options = {
          "awslogs-group"         = aws_cloudwatch_log_group.log_group.id,
          "awslogs-region"        = var.region ,
          "awslogs-stream-prefix" = "ecs"
        }
      }
    }
  ])
}


# Service
resource "aws_ecs_service" "ecs_service" {
  name                              = var.service_name
  cluster                           = aws_ecs_cluster.ecs_cluster.id
  task_definition                   = aws_ecs_task_definition.ecs_task_definition.arn
  launch_type                       = "EC2"
  desired_count                     = var.service_desired_count
  force_new_deployment              = true
  health_check_grace_period_seconds = 150

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = var.container_name 
    container_port   = var.containerport
  }

  depends_on = [var.ecs_auto_scaling_group_arn]
}

# Create a new ALB Target Group attachment
resource "aws_autoscaling_attachment" "auto_attachment" {
  autoscaling_group_name = var.ecs_auto_scaling_group_name
  lb_target_group_arn    = var.target_group_arn
}



#Service Autoscaling
resource "aws_appautoscaling_target" "ecs_target" {
  max_capacity       = var.service_asg_max_capcacity 
  min_capacity       = var.service_asg_min_capcacity
  resource_id        = "service/${aws_ecs_cluster.ecs_cluster.name}/${aws_ecs_service.ecs_service.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}

## Policy for CPU tracking
resource "aws_appautoscaling_policy" "ecs_cpu_policy" {
  name               = "Service_CPUTargetTrackingScaling_policy"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.ecs_target.resource_id
  scalable_dimension = aws_appautoscaling_target.ecs_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.ecs_target.service_namespace

  target_tracking_scaling_policy_configuration {
    target_value = var.service_asg_target_tracking_value 

    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }
  }
}