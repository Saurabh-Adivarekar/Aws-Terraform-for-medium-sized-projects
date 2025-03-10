# Key pair
resource "aws_key_pair" "ecs_key" {
  key_name   = var.key_name
  public_key = tls_private_key.rsa.public_key_openssh
}
resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
resource "local_file" "ecs_key" {
  content         = tls_private_key.rsa.private_key_pem
  filename        = var.key_name
  file_permission = 400
}


# launch template
resource "aws_launch_template" "aws_lt" {
  name = var.launch_template_name

  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      volume_size = 20
    }
  }

  iam_instance_profile {
    name = "ecsInstanceRole"
  }

  monitoring {
    enabled = true
  }

  image_id = var.image_id

  instance_type = var.instance_type

  key_name = aws_key_pair.ecs_key.id

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = var.ecs_ec2_tag
    }
  }

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.ecs_ec2_sg.id]
  }

  user_data = filebase64("${path.module}/user-data-ecs.sh") #base64encode(file("../../../Module/compute/user-data-ecs.sh"))
}


# Auto scaling group
resource "aws_autoscaling_group" "ecs_asg" {
  name                = var.asg_name
  desired_capacity    = var.asg_desired_capacity
  max_size            = var.asg_min_size
  min_size            = var.asg_max_size
  vpc_zone_identifier = [var.subnet1_id, var.subnet2_id]

  launch_template {
    id      = aws_launch_template.aws_lt.id
    version = aws_launch_template.aws_lt.latest_version
  }

  tag {
    key                 = "Name"
    value               = var.ecs_ec2_tag
    propagate_at_launch = true
  }

}


# Ec2 Security Group
resource "aws_security_group" "ecs_ec2_sg" {
  name   = var.ecs_ec2_sg_name
  vpc_id = var.vpc_id
}

resource "aws_security_group_rule" "ingress_ec2_sg_rule" {
  for_each = var.ingress_ec2_sg_rule

  type                     = "ingress"
  from_port                = each.value.from_port
  to_port                  = each.value.to_port
  protocol                 = each.value.protocol
  cidr_blocks              = try(each.value.cidr_blocks, null)
  security_group_id        = aws_security_group.ecs_ec2_sg.id
  source_security_group_id = try(each.value.cidr_blocks, null) == null ? try(aws_security_group.ecs_alb_sg.id, null) : null
}

resource "aws_security_group_rule" "egress_ec2_sg_rule" {
  for_each = var.egress_ec2_sg_rule

  type              = "egress"
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  protocol          = each.value.protocol
  cidr_blocks       = try(each.value.cidr_blocks, null)
  security_group_id = aws_security_group.ecs_ec2_sg.id
}


# ALB Security Group
resource "aws_security_group" "ecs_alb_sg" {
  name   = var.ecs_alb_sg_name
  vpc_id = var.vpc_id

}

resource "aws_security_group_rule" "ingress_alb_sg_rule" {
  for_each = var.ingress_alb_sg_rule

  type              = "ingress"
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  protocol          = each.value.protocol
  cidr_blocks       = try(each.value.cidr_blocks, null)
  security_group_id = aws_security_group.ecs_alb_sg.id
}

resource "aws_security_group_rule" "egress_alb_sg_rule" {
  for_each = var.egress_alb_sg_rule

  type                     = "egress"
  from_port                = each.value.from_port
  to_port                  = each.value.to_port
  protocol                 = each.value.protocol
  cidr_blocks              = try(each.value.cidr_blocks, null)
  security_group_id        = aws_security_group.ecs_alb_sg.id
  source_security_group_id = try(each.value.cidr_blocks, null) == null ? try(aws_security_group.ecs_ec2_sg.id, null) : null
}


# application load balancer
resource "aws_lb" "ecs_alb" {
  name               = var.ecs_alb_name #"ecs-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.ecs_alb_sg.id]
  subnets            = [var.subnet1_id, var.subnet2_id]
  idle_timeout       = 120

}

resource "aws_lb_listener" "ecs_alb_listener" {
  load_balancer_arn = aws_lb.ecs_alb.arn
  port              = 80
  protocol          = var.lb_protocol #"HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ecs_tg.arn
  }
}

resource "aws_lb_target_group" "ecs_tg" {
  name        = var.ecs_tg_name #"ecs-target-group"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = var.vpc_id

  health_check {
    path = "/"
  }
}
