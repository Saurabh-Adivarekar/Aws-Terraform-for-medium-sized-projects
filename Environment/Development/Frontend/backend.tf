terraform {
  backend "s3" {
    bucket  = "template-infra-frontend-dev-terraform"
    encrypt = true
    key     = "terraform-infra-dev.tfstate"
    region  = "ap-south-1"
  }
}