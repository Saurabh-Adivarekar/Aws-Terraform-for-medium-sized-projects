data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["codepipeline.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

# data "aws_iam_policy_document" "codepipeline_policy_fe" {
#   statement {
#     effect = "Allow"

#     actions = [
#       "s3:GetObject",
#       "s3:GetObjectVersion",
#       "s3:GetBucketVersioning",
#       "s3:PutObjectAcl",
#       "s3:PutObject",
#     ]

#     resources = [
#       module.codepipeline_fe.output_codepipeline_bucket_arn,
#       "${module.codepipeline_fe.output_codepipeline_bucket_arn}/*"
#     ]
#   }

#   statement {
#     effect    = "Allow"
#     actions   = ["codestar-connections:UseConnection"]
#     resources = [var.codestar_arn]
#   }

#   statement {
#     effect = "Allow"

#     actions = [
#       "codebuild:BatchGetBuilds",
#       "codebuild:StartBuild",
#     ]

#     resources = ["*"]
#   }
# }


data "aws_iam_policy_document" "codepipeline_policy_be" {
  statement {
    effect = "Allow"

    actions = [
      "s3:GetObject",
      "s3:GetObjectVersion",
      "s3:GetBucketVersioning",
      "s3:PutObjectAcl",
      "s3:PutObject",
    ]

    resources = [
      module.codepipeline_be.output_codepipeline_bucket_arn,
      "${module.codepipeline_be.output_codepipeline_bucket_arn}/*"
    ]
  }

  statement {
    effect    = "Allow"
    actions   = ["codestar-connections:UseConnection"]
    resources = [var.codestar_arn]
  }

  statement {
    effect = "Allow"

    actions = [
      "codebuild:BatchGetBuilds",
      "codebuild:StartBuild",
      "ecs:*"
    ]

    resources = ["*"]
  }


  statement {
    effect = "Allow"

    actions = [
      "ecs:*",
      "iam:PassRole",
    ]

    resources = ["*"]
  }
}


# module "codepipeline_fe" {
#   source = "../../../Module/codepipeline"

#   codestar_provider_type   = var.codestar_provider_type_fe
#   codepipeline_bucket_name = var.codepipeline_bucket_name_fe
#   codepipeline_role_name   = var.codepipeline_role_name_fe
#   assume_role_policy       = data.aws_iam_policy_document.assume_role.json
#   codepipeline_policy_name = var.codepipeline_policy_name_fe
#   codepipeline_policy      = data.aws_iam_policy_document.codepipeline_policy_fe.json
#   codepipeline_name        = var.codepipeline_name_fe
#   FullRepositoryId         = var.FullRepositoryId_fe
#   BranchName               = var.BranchName_fe
#   codebuild_project_name   = var.codebuild_project_name_frontend
#   codestar_arn             = var.codestar_arn
#   ecs_service_id           = module.ecs.output_ecs_service_id
# }

module "codepipeline_be" {
  source = "../../../Module/codepipeline"

  codestar_provider_type   = var.codestar_provider_type_be
  codepipeline_bucket_name = var.codepipeline_bucket_name_be
  codepipeline_role_name   = var.codepipeline_role_name_be
  assume_role_policy       = data.aws_iam_policy_document.assume_role.json
  codepipeline_policy_name = var.codepipeline_policy_name_be
  codepipeline_policy      = data.aws_iam_policy_document.codepipeline_policy_be.json
  codepipeline_name        = var.codepipeline_name_be
  FullRepositoryId         = var.FullRepositoryId_be
  BranchName               = var.BranchName_be
  codebuild_project_name   = var.codebuild_project_name_backend
  codestar_arn             = var.codestar_arn
  ecs_service_id           = module.ecs.output_ecs_service_id
  service_name             = var.service_name
  cluster_name             = var.cluster_name
}
