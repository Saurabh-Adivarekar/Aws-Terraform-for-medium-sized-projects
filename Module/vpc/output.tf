output "output_subnet1_id" {
  value = aws_subnet.subnets[0].id
}

output "output_subnet2_id" {
  value = aws_subnet.subnets[1].id
}

output "output_vpc_id" {
  value = aws_vpc.vpc.id
}
