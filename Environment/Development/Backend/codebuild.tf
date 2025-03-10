
## CodeBuild assume role policy

data "aws_iam_policy_document" "codebuild_assume_role_policy" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["codebuild.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

## CodeBuild frontend IAM policy

data "aws_iam_policy_document" "codebuild_cloudfront_and_s3_policy" {
  statement {
    effect = "Allow"

    actions = [
      "logs:*",
      "ecs:*",
      "s3:*",
      "cloudfront:*",
      "ssm:*",
      "secretsmanager:*"
    ]

    resources = ["*"]
  }
}

## CodeBuild module for frontend

module "codebuild_app" {
  source = "../../../Module/codebuild"

  codebuild_iam_role_name               = var.codebuild_iam_role_name_frontend
  codebuild_iam_role_assume_role_policy = data.aws_iam_policy_document.codebuild_assume_role_policy.json
  codebuild_iam_role_policy             = data.aws_iam_policy_document.codebuild_cloudfront_and_s3_policy.json
  codebuild_project_name                = var.codebuild_project_name_frontend

  environment_compute_type = var.codebuild_environment_compute_type
  environment_variable     = var.codebuild_environment_variable_frontend
  codebuild_source         = var.codebuild_source
  vpc_config               = var.codebuild_vpc_config

}

## CodeBuild backend IAM policy

data "aws_iam_policy_document" "codebuild_api_dev_policy" {
  statement {
    effect = "Allow"

    actions = [
      "ecr:*",
      "ecs:*",
      "logs:*",
      "s3:*",
      "ssm:*",
      "lambda:*"
    ]

    resources = ["*"]
  }
}

## CodeBuild module for backend

module "codebuild_api" {
  source = "../../../Module/codebuild"

  codebuild_iam_role_name               = var.codebuild_iam_role_name_backend
  codebuild_iam_role_assume_role_policy = data.aws_iam_policy_document.codebuild_assume_role_policy.json
  codebuild_iam_role_policy             = data.aws_iam_policy_document.codebuild_api_dev_policy.json
  codebuild_project_name                = var.codebuild_project_name_backend

  environment_compute_type = var.codebuild_environment_compute_type
  environment_variable     = var.codebuild_environment_variable_backend
  codebuild_source         = var.codebuild_source
  vpc_config               = var.codebuild_vpc_config

}
