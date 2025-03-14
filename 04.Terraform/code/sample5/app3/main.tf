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

module "private" {
    source = "./modules/private_infra"
    vpc_id = aws_vpc.my_vpc.id  
    security_group_id = aws_security_group.my_vpc_default_sg.id
    # instance_type = "m6.large"
}

module "public" {
    source = "./modules/public_infra"
    vpc_id = aws_vpc.my_vpc.id 
    security_group_id = aws_security_group.my_vpc_default_sg.id
    # instance_type = "m6.large"
}