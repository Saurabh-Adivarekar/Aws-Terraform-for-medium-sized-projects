#compute 
region               = "eu-west-2"                                    # AWS region where resources will be created (London region)
image_id             = "ami-0076be86944570bff"                        # Amazon Machine Image (AMI) ID used to launch EC2 instances
key_name             = "template-key.pem"                             # The key pair name used for SSH access to EC2 instances
launch_template_name = "template-lt"                                  # Name of the launch template used to configure EC2 instances
instance_type        = "t2.medium"                                    # The type of EC2 instance to launch (a medium instance type with 2 vCPUs and 4GB RAM)
ecs_ec2_tag          = "template_ecs_instance"                        # Tag for the EC2 instance to identify it in ECS
asg_name             = "template_ecs_asg"                             # Name of the Auto Scaling Group (ASG) for managing EC2 instance scaling
ecs_ec2_sg_name      = "template_ecs_ec2_sg"                          # Security Group for the EC2 instances in ECS cluster
ecs_alb_sg_name      = "template_ecs_alb_sg"                          # Security Group for the Application Load Balancer (ALB)
lb_protocol          = "HTTP"                                         # The protocol used by the Load Balancer (HTTP in this case)
ecs_alb_name         = "template-ecs-alb"                             # Name of the Application Load Balancer (ALB) for ECS services
ecs_tg_name          = "template-ecs-tg"                              # Name of the Target Group used by the Load Balancer to route traffic to ECS instances


#ecs
account_id                        = 540548458470                          # AWS account ID for identifying the account where resources will be created
cluster_name                      = "template-ecs-cluster"                # The name of the ECS cluster that will run the tasks and services
capacity_provider_name            = "template_capacity_provider"          # Name of the capacity provider used to manage EC2 capacity in ECS
aws_cloudwatch_log_group_name     = "template_cw_log_group"               # Name of the CloudWatch log group for storing ECS task logs
ecs_task_definition_name          = "template_td"                         # The name of the ECS task definition, which describes the containers and configurations for tasks
container_name                    = "ttm-app-dev-container"               # Name of the container within the ECS task definition (container that runs the app)
service_name                      = "template-ecs-service"                # The name of the ECS service that will manage the task definitions and ensure they are running
task_cpu                          = 850                                   # CPU resources allocated for each ECS task (850 CPU units, roughly 0.85 vCPU)
task_memory                       = 1946                                  # Memory resources allocated for each ECS task (1946 MB of RAM)
containerport                     = 8000                                  # The port on the container that will be exposed for incoming traffic
hostport                          = 0                                     # The port on the host machine (EC2) that the container will map to; 0 means random allocation
service_desired_count             = 1                                     # The desired number of tasks for the ECS service to run at all times (1 task)
service_asg_max_capacity          = 4                                     # Maximum number of EC2 instances in the Auto Scaling Group for the service
service_asg_min_capacity          = 1                                     # Minimum number of EC2 instances in the Auto Scaling Group for the service
service_asg_target_tracking_value = 70                                    # Target tracking value for the Auto Scaling Group, determines the scaling policy (e.g., CPU utilization)


#vpc module

vpc_name               = "template_vpc"                                          # The name of the Virtual Private Cloud (VPC)
cidr_block             = "10.0.0.0/16"                                           # The CIDR block for the VPC's IP address range
instance_tenancy       = "default"                                               # The tenancy option for instances (default is shared tenancy)
cidr_subnets           = ["10.0.1.0/24", "10.0.2.0/24","10.0.3.0/24"]            # The CIDR blocks for the subnets within the VPC
az                     = ["eu-west-2a", "eu-west-2b","eu-west-2c"]               # Availability Zones to be used for subnet distribution
public_route_table_tag = "PublicRouteTable"                                      # The tag for the route table associated with the public subnet
ig_tag                 = "internet_gateway"                                      # The tag for the internet gateway for VPC internet access



#ec2 sg
ingress_ec2_sg_rule = {
  inbound_ssh = {
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  },
  inbound_80 = {
    from_port = 80
    to_port   = 80
    protocol  = "TCP"
  },
  inbound_all_tcp = {
    from_port = 0
    to_port   = 65535
    protocol  = "TCP"
  }
}

egress_ec2_sg_rule = {
  outbound_all = {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#alb sg
ingress_alb_sg_rule = {
  inbound_80 = {
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  },
  inbound_443 = {
    from_port   = 443
    to_port     = 443
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  },
  inbound_all_tcp = {
    from_port   = 0
    to_port     = 65535
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

egress_alb_sg_rule = {
  outbound_80 = {
    from_port = 80
    to_port   = 80
    protocol  = "TCP"
  },
  outbound_all_tcp = {
    from_port = 0
    to_port   = 65535
    protocol  = "TCP"

  }
}

#asg
asg_desired_capacity = 1                                               # The desired number of instances in the Auto Scaling Group
asg_max_size         = 1                                               # The maximum number of instances that the Auto Scaling Group can scale up to
asg_min_size         = 1                                               # The minimum number of instances that the Auto Scaling Group will maintain


#ecr module
ecr_repo_name = "template-ecr_repo"                                    # The name of the Elastic Container Registry (ECR) repository

#codebuild
codebuild_iam_role_name_frontend = "template-app-codebuild-dev-role"   # IAM role for CodeBuild project in the frontend environment
codebuild_project_name_frontend  = "template-app-dev"                  # CodeBuild project name for the frontend build

codebuild_iam_role_name_backend = "template-api-codebuild-dev-role"    # IAM role for CodeBuild project in the backend environment
codebuild_project_name_backend  = "template-api-dev"                   # CodeBuild project name for the backend build

codebuild_environment_compute_type = "BUILD_GENERAL1_SMALL"            # The compute type for the CodeBuild environment (small compute resources)

codebuild_source = {
  type      = "CODEPIPELINE"                                           # The source of the build is from AWS CodePipeline
  buildspec = "buildspec-dev.yml"                                      # The buildspec file for the build process
  location  = ""                                                       # The location of the source code (empty for integration with CodePipeline)
}


# codebuild_environment_variable_backend = [  # Environment variables for the backend CodeBuild project
#   {
#     name  = "DATABASE_URL"                  # The name of the environment variable (DATABASE_URL)
#     value = "DATABASE_URL_DEV"              # The value of the environment variable (the parameter store reference for dev DB URL)
#     type  = "PARAMETER_STORE"               # The type of value (in this case, using Parameter Store for the value)
#   },
#   {
#     name  = "IMAGE_TAG"                     # The name of the environment variable (IMAGE_TAG)
#     value = "IMAGE_TAG_DEV"                 # The value of the environment variable (the parameter store reference for dev image tag)
#     type  = "PARAMETER_STORE"               # The type of value (using Parameter Store)
#   }
# ]

# codebuild_environment_variable_frontend = [  # Environment variables for the frontend CodeBuild project
#   {
#     name  = "DISTRIBUTION_ID"               # The name of the environment variable (DISTRIBUTION_ID)
#     value = "DISTRIBUTION_ID_DEV"           # The value of the environment variable (the parameter store reference for dev distribution ID)
#     type  = "PARAMETER_STORE"               # The type of value (using Parameter Store for the value)
#   },
#   {
#     name  = "S3_BUCKET_NAME"                # The name of the environment variable (S3_BUCKET_NAME)
#     value = "S3_BUCKET_NAME_DEV"            # The value of the environment variable (the parameter store reference for dev S3 bucket)
#     type  = "PARAMETER_STORE"               # The type of value (using Parameter Store)
#   }
# ]



#codepipeline fe
codestar_arn = "arn:aws:codeconnections:eu-west-1:540548458470:connection/d12e0002-97a4-43d2-86e8-784425f53477"  # The ARN of the AWS CodeStar connection


codestar_provider_type_fe   = "GitLab"                              # The provider type for the frontend CodeStar connection (GitLab)
codepipeline_bucket_name_fe = "template-bucket-code-pipeline-fe"    # The S3 bucket name for the frontend CodePipeline
codepipeline_role_name_fe   = "template-codepipeline-role_fe"       # The IAM role name used by the frontend CodePipeline
codepipeline_policy_name_fe = "template-codepipeline-policy-fe"     # The IAM policy name associated with the frontend CodePipeline
codepipeline_name_fe        = "template-pipeline_fe"                # The name of the frontend CodePipeline
FullRepositoryId_fe         = "FiftyFiveTech/template"              # The full repository ID for the frontend (GitLab repo)
BranchName_fe               = "master"                              # The branch name for the frontend repository (GitLab)

#codepipeline be

codestar_provider_type_be   = "Bitbucket"                           # The provider type for the backend CodeStar connection (Bitbucket)
codepipeline_bucket_name_be = "template-bucket-code-pipeline-be"    # The S3 bucket name for the backend CodePipeline
codepipeline_role_name_be   = "template-codepipeline-role_be"       # The IAM role name used by the backend CodePipeline
codepipeline_policy_name_be = "template-codepipeline-policy-be"     # The IAM policy name associated with the backend CodePipeline
codepipeline_name_be        = "template-pipeline_be"                # The name of the backend CodePipeline
FullRepositoryId_be         = "trainingmarketplace/ttm-app"         # The full repository ID for the backend (Bitbucket repo)
BranchName_be               = "dev"                                 # The branch name for the backend repository (Bitbucket)

