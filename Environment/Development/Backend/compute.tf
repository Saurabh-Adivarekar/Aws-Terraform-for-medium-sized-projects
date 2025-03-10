module "compute" {
  source = "../../../Module/compute"

  key_name             = var.key_name
  image_id             = var.image_id
  launch_template_name = var.launch_template_name
  ecs_ec2_tag          = var.ecs_ec2_tag
  ecs_ec2_sg_name      = var.ecs_ec2_sg_name
  ecs_alb_sg_name      = var.ecs_alb_sg_name
  lb_protocol          = var.lb_protocol
  ecs_alb_name         = var.ecs_alb_name
  ecs_tg_name          = var.ecs_tg_name
  asg_name             = var.asg_name
  instance_type        = var.instance_type
  asg_desired_capacity = var.asg_desired_capacity
  asg_max_size         = var.asg_max_size
  asg_min_size         = var.asg_min_size
  ingress_ec2_sg_rule  = var.ingress_ec2_sg_rule
  egress_ec2_sg_rule   = var.egress_ec2_sg_rule
  ingress_alb_sg_rule  = var.ingress_alb_sg_rule
  egress_alb_sg_rule   = var.egress_alb_sg_rule
  subnet1_id           = module.vpc.output_subnet1_id
  subnet2_id           = module.vpc.output_subnet2_id
  vpc_id               = module.vpc.output_vpc_id
}
