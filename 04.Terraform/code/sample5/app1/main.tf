terraform {
    required_version = ">= 1.10.0"
    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "5.84.0"
        }
    }
}

provider "aws" {
    region = "us-east-1"
}

resource "aws_vpc" "my_vpc" {
    # cidr block
    cidr_block = var.vpc_cidr

    # instances will be created on default (shared) tenancy basis
    instance_tenancy = "default"

    # set the tags
    tags = {
        Name = "my_vpc"
    }  
}

# create the private subnet
resource "aws_subnet" "private_subnet" {
    # get the newly created vpc id
    vpc_id     = aws_vpc.my_vpc.id

    # cidr block for public subnet
    cidr_block = var.private_subnet_cidr

    # set the tags
    tags = {
        Name = "private_subnet"
    }
}

# create a private route table
resource "aws_route_table" "private_route_table" {
    # get the newly created vpc id
    vpc_id = aws_vpc.my_vpc.id

    # set the tags
    tags = {
        Name = "my_private_route_table"
    }
}


# associate the route table with the private subnet
resource "aws_route_table_association" "private_subnet_association" {

    # get the newly created route table id
    subnet_id      = aws_subnet.private_subnet.id

    # get the newly created route table id
    route_table_id = aws_route_table.private_route_table.id
}

# create a security group
resource "aws_security_group" "my_vpc_default_sg" {
    # get the newly created vpc id
    vpc_id = aws_vpc.my_vpc.id

    # set the tags
    tags = {
        Name = "my_sg"
    }

    # allow all inbound traffic
    ingress {
        from_port = 22
        to_port = 22
        protocol    = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
    }

    # allow all outbound traffic
    egress {
        from_port = 0
        to_port = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

# create ec2 instance in the public subnet
resource "aws_instance" "private_ec2" {
    # specify the ami id
    ami           = var.ubuntu_ami

    # specify the instance type
    instance_type = var.instance_type

    # specify the key name
    key_name = var.key_name
    
    # specify the subnet id
    subnet_id     = aws_subnet.private_subnet.id

    # specify the security group
    vpc_security_group_ids = [aws_security_group.my_vpc_default_sg.id]

    # set the tags
    tags = {
      Name = "private_ec2"
    }
}

# create public subnet
resource "aws_subnet" "public_subnet" {
    # get the newly created vpc id
    vpc_id     = aws_vpc.my_vpc.id

    # cidr block for public subnet
    cidr_block = var.public_subnet_cidr

    # set the public ip address to ec2 instance on launch
    map_public_ip_on_launch = true

    # set the tags
    tags = {
        Name = "public_subnet"
    }
}

# create the internet gateway
resource "aws_internet_gateway" "my_igw" {
    # get the newly created vpc id
    vpc_id = aws_vpc.my_vpc.id

    # set the tags
    tags = {
        Name = "my_igw"
    }
}


# create a route table
resource "aws_route_table" "public_route_table" {
    # get the newly created vpc id
    vpc_id = aws_vpc.my_vpc.id

    # set the tags
    tags = {
        Name = "my_public_route_table"
    }
}

# associate the internet gateway with the route table
resource "aws_route" "route_to_igw" {
    # get the newly created route table id
    route_table_id         = aws_route_table.public_route_table.id

    # destination cidr block
    destination_cidr_block = "0.0.0.0/0"

    # associate the internet gateway with the route table
    gateway_id             = aws_internet_gateway.my_igw.id
}


# associate the route table with the public subnet
resource "aws_route_table_association" "public_subnet_association" {

    # get the newly created route table id
    subnet_id      = aws_subnet.public_subnet.id

    # get the newly created route table id
    route_table_id = aws_route_table.public_route_table.id
}

# create ec2 instance in the public subnet
resource "aws_instance" "public_ec2" {
    # specify the ami id
    ami           = var.ubuntu_ami

    # specify the instance type
    instance_type = var.instance_type

    # specify the key name
    key_name = var.key_name
    
    # specify the subnet id
    subnet_id     = aws_subnet.public_subnet.id

    # specify the security group
    vpc_security_group_ids = [aws_security_group.my_vpc_default_sg.id]

    # set the tags
    tags = {
      Name = "public_ec2"
    }
}


