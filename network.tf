### This file is for creating network components in AWS ###


## Define VPC

resource "aws_vpc" "elbvpc" {
  cidr_block = var.vpc_cidr
  enable_dns_hostnames = true

  tags = {
    Name = "elbvpc"
  }
}


## Define public subnet

resource "aws_subnet" "public-subnet" {
  vpc_id = aws_vpc.elbvpc.id
  cidr_block = var.public_subnet_cidr
  availability_zone = "us-west-2a"

  tags = {
    Name = "lb_Public_Subnet"
  }
}


## Define Internet Gateway

resource "aws_internet_gateway" "lbgw" {
  vpc_id = aws_vpc.elbvpc.id

  tags = {
    Name = "vpc_lb_igw"
  }
}

## Define the route table

resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.elbvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.lbgw.id
  }

  tags = {
    Name = "Public_Subnet_RT"
  }
}


## Assign the route table to the public Subnet


resource "aws_route_table_association" "public-rt" {
  subnet_id = aws_subnet.public-subnet.id
  route_table_id = aws_route_table.public-rt.id
}

## ALB (Nginx) Security Group

resource "aws_security_group" "lbsg" {
  name = "ec2-elb-sg"

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = -1
    to_port = -1
    protocol = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = aws_vpc.elbvpc.id

  tags = {
    Name = "LB_SG"
  }
}

## Instance Security Group

resource "aws_security_group" "instancesg"{
  name = "instance_sec_grp"
  description = "Allow traffic from public subnet"

  ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = ["${var.vpc_cidr}"]
  }

  ingress {
    from_port = -1
    to_port = -1
    protocol = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = aws_vpc.elbvpc.id

  tags = {
    Name = "Instance_SG"
  }
}

