# vpc
resource "aws_vpc" "vpc" {
  cidr_block       = var.cidr_block 
  instance_tenancy = var.instance_tenancy

  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "subnets" {
  count = length(var.cidr_subnets)

  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.cidr_subnets[count.index]
  availability_zone = var.az[count.index]
  tags = {
    Name = "ecs_subnet${count.index + 1}"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = var.ig_tag
  }
}


#Public Route Table
resource "aws_route_table" "PublicRT" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = var.public_route_table_tag
  }
}


#Public Route Table Association
resource "aws_route_table_association" "public_rt_subnet_association" {
  count = length(var.az)

  subnet_id      = aws_subnet.subnets[count.index].id
  route_table_id = aws_route_table.PublicRT.id

}


#Elastic IP
resource "aws_eip" "elasticIP" {
  domain = "vpc"
}
