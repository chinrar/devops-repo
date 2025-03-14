variable "vpc_id" {
  type = string
}

variable "security_group_id" {
  type = string  
}

variable "private_subnet_cidr" {
  type = string
  default = "10.10.10.0/24"
}

variable "ubuntu_ami" {
  type = string
  default = "ami-04b4f1a9cf54c11d0"
}

variable "instance_type" {
  type = string
  default = "t2.micro"
}

variable "key_name" {
  type = string
  default = "key-demops"  
}