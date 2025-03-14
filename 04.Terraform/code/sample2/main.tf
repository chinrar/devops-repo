# this is the main block
terraform {

  # required_version is the version of terraform that you want to use
  required_version = ">= 1.10.0"

  # required_providers is the provider block that you want to use
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.84.0"
    }
  }
}

# provider block is used to configure the provider
provider "aws" {

  # north Virginia region
  region = "us-east-1"

  # access_key = ""
  # secret_key = ""  
}

# create an ec2 instance
resource "aws_instance" "webserver" {
  # name of the ami used to create the instance
  ami = "ami-04b4f1a9cf54c11d0"

  # select the instance type
  instance_type = "t2.micro"

  # provide the configuration to be executed when the instance starts
  user_data = "sudo apt-get update && sudo apt-get install apache2 -y"

  # specify the key pair to be used to connect to the instance
  key_name = "key-demops"

  # create a tag
  tags = {
    # name will appear in the aws console
    Name = "apache-server"
  }

  # ebs_block_device {
  #   device_name = "/dev/sdh"
  #   volume_type = "gp3"
  #   volume_size = 30
  #   delete_on_termination = true
  # }
}

# create a s3 bucket
resource "aws_s3_bucket" "my_bucket" {

  # specify the name
  bucket = "com-amitk-sunbeam-bucket1"

  # provide the tags
  tags = {
    Name = "my_bucket"
  }
}