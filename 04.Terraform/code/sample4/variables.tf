variable "vpc_cidr" {
  type = string
  default = "10.10.0.0/16"
}

variable "private_subnet_cidr" {
  type = string
  default = "10.10.0.0/24"
}

variable "public_subnet_cidr" {
  type = string
  default = "10.10.1.0/24"
}

variable "ubuntu_ami" {
  type = string
  default = "ami-00bb6a80f01f03502"
}

variable "instance_type" {
  type = string
  default = "t2.micro"
}

variable "key_name" {
  type = string
  default = "devops-key"
}

