module "ecr_module" {
  source = "../../../Module/ecr"

  ecr_repo_name = var.ecr_repo_name
}