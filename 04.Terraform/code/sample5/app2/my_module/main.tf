terraform {
  required_version = ">= 1.10.0"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.84.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "my_instance" {
  ami           = var.ubuntu_ami
  instance_type = var.instance_type
  key_name = var.key_name
}