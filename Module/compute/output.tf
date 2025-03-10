output "output_security_group_id" {
    value = aws_security_group.ecs_ec2_sg.id
}

output "output_aws_key_pair_id" {
    value = aws_key_pair.ecs_key.id
}

output "output_ecs_autoscaling_group_arn" {
    value = aws_autoscaling_group.ecs_asg.arn
}

output "output_ecs_auto_scaling_group_name" {
    value = aws_autoscaling_group.ecs_asg.name
} 

output "output_target_group_arn" {
  value = aws_lb_target_group.ecs_tg.arn
}

output "output_alb_dns" {
  value = aws_lb.ecs_alb.dns_name
}