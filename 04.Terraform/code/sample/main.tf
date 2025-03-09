terraform {
    required_version = ">= 1.0.0"
    required_providers {
      aws = {
        source = "hashicorp/aws"
        version = "5.90.0"
      }
  }   
}

provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "web-server" {
  ami           = "ami-00bb6a80f01f03502"
  instance_type = "t2.micro"
  key_name      = "devops-key"
  tags = {
    Name = "Web Server"
  }
}