## IAM Role for CodeBuild
resource "aws_iam_role" "codebuild_iam_role" {
  name               = var.codebuild_iam_role_name
  assume_role_policy = var.codebuild_iam_role_assume_role_policy
}

## IAM Role Policy
resource "aws_iam_role_policy" "codebuild_iam_role_policy" {
  role   = aws_iam_role.codebuild_iam_role.name
  policy = var.codebuild_iam_role_policy
}

## CodeBuild Project
resource "aws_codebuild_project" "codebuild_infra" {
  name          = var.codebuild_project_name
  description   = var.codebuild_project_description
  service_role  = aws_iam_role.codebuild_iam_role.arn

  artifacts {
    type = var.codebuild_source.type
  }

  environment {
    compute_type    = var.environment_compute_type
    image           = "aws/codebuild/standard:5.0"
    type            = "LINUX_CONTAINER"
    privileged_mode = true

    dynamic "environment_variable" {
      for_each = var.environment_variable

      content {
        name  = try(environment_variable.value.name, null)
        value = try(environment_variable.value.value, null)
        type  = try(environment_variable.value.type, null)
      }
    }
  }

  source {
    type            = var.codebuild_source.type
    location        = var.codebuild_source.location
    buildspec       = var.codebuild_source.buildspec
    git_clone_depth = 0
  }

  dynamic "vpc_config" {
    for_each = var.vpc_config

    content {
      vpc_id             = try(vpc_config.value.vpc_id, null)
      subnets            = try(vpc_config.value.subnets, null)
      security_group_ids = try(vpc_config.value.security_group_ids, null)
    }
  }

  tags = var.tags
}
