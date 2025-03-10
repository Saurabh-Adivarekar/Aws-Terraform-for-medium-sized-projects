terraform {
  backend "s3" {
    bucket  = "template-infra-backend-dev-terraform-bucket"
    encrypt = true
    key     = "terraform-infra-dev.tfstate"
    region  = "eu-west-2"
  }
}