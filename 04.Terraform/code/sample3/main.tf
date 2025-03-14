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
  # referencing the variable aws_region
  region = var.aws_region
}

resource "aws_instance" "webserver" {
  ami           = var.ec2_ami
  instance_type = var.ec2_instance_type
  key_name      = var.ec2_key_name

  tags = {
    Name = "webserver"
  }
}