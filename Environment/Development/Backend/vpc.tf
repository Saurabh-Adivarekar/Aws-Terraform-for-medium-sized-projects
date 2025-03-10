module "vpc" {
  source = "../../../Module/vpc"

  vpc_name               = var.vpc_name
  cidr_block             = var.cidr_block
  instance_tenancy       = var.instance_tenancy
  cidr_subnets           = var.cidr_subnets
  az                     = var.az
  public_route_table_tag = var.public_route_table_tag
  ig_tag                 = var.ig_tag
}
