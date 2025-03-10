resource "aws_s3_bucket" "codepipeline_bucket" {
  bucket = var.codepipeline_bucket_name 
  force_destroy = true                                  
}

resource "aws_s3_bucket_public_access_block" "codepipeline_bucket_pab" {
  bucket = aws_s3_bucket.codepipeline_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_iam_role" "codepipeline_role" {
  name               = var.codepipeline_role_name 
  assume_role_policy = var.assume_role_policy 
}

resource "aws_iam_role_policy" "codepipeline_policy" {
  name   = var.codepipeline_policy_name 
  role   = aws_iam_role.codepipeline_role.id
  policy = var.codepipeline_policy         
}


resource "aws_codepipeline" "codepipeline" {
  name     = var.codepipeline_name 
  role_arn = aws_iam_role.codepipeline_role.arn
  pipeline_type = "V2"
  execution_mode = "QUEUED"

  artifact_store {
    location = aws_s3_bucket.codepipeline_bucket.bucket
    type     = "S3"
   }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      output_artifacts = ["source_output"]  

      configuration = {
        ConnectionArn    = var.codestar_arn 
        FullRepositoryId = var.FullRepositoryId 
        BranchName       = var.BranchName       
      }
    }
  }

  stage {
    name = "Build"

    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["source_output"] 
      output_artifacts = ["build_output"]  
      version          = "1"

      configuration = {
        ProjectName = var.codebuild_project_name 
      }
    }
  }


  stage {
  name = "Deploy"

  action {
    name            = "Deploy"
    category        = "Deploy"
    owner           = "AWS"
    provider        = "ECS"
    input_artifacts = ["build_output"]
    version         = "1"

    configuration = {
      ClusterName    = var.cluster_name     
      ServiceName    = var.service_name    
      FileName       = "imagedefinitions.json"  
    }
  }
}

  depends_on = [ var.ecs_service_id ]
}
