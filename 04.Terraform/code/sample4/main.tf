terraform {
  required_version = ">=1.10.0"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.91.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"

  tags = {
    Name = "main"
  }
}

resource "aws_internet_gateway" "my_gateway" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "my_gateway"
  }
}


resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.public_subnet_cidr
  map_public_ip_on_launch = true

  tags = {
    Name = "public_subnet"
  }
}
resource "aws_route_table" "rt_public" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "rt_public"
  }
}

# create route to internet gateway
resource "aws_route" "route_public" {
  route_table_id         = aws_route_table.rt_public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.my_gateway.id
}

resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.rt_public.id
}

# create security group
resource "aws_security_group" "ssh_sg" {
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { name = "ssh_sg" }
}

# create ec2 instance in public subnet
resource "aws_instance" "public_instance" {
  ami           = var.ubuntu_ami
  instance_type = var.instance_type
  key_name      = var.key_name
  subnet_id     = aws_subnet.public_subnet.id

  # associate public security group with instance
  vpc_security_group_ids = [aws_security_group.ssh_sg.id]

  tags = {
    Name = "public_instance"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.private_subnet_cidr
  map_public_ip_on_launch = false

  tags = {
    Name = "private_subnet"
  }
}

resource "aws_route_table" "rt_private" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "rt_private"
  }
}

resource "aws_route_table_association" "private_assoc" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.rt_private.id
}

resource "aws_instance" "private_instance" {
  ami           = var.ubuntu_ami
  instance_type = var.instance_type
  key_name      = var.key_name
  subnet_id     = aws_subnet.private_subnet.id

  # associate public security group with instance
  vpc_security_group_ids = [aws_security_group.ssh_sg.id]

  tags = {
    Name = "private_instance"
  }
}