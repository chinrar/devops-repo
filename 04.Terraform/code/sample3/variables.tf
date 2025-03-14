# variable to store the region value
# when you do terraform plan, it will ask for value
variable "aws_region" {
  type    = string
  # default = "us-east-1"
}

# variable to store the ami value
variable "ec2_ami" {
  type    = string
  default = "ami-04b4f1a9cf54c11d0"
}

# variable to store the instance type value
# when you do terraform plan, it will ask for value
variable "ec2_instance_type" {
  type    = string
  # default = "t2.micro"
}

# variable to store the key name value
variable "ec2_key_name" {
  type    = string
  default = "key-demops"
}
