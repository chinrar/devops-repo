# creating VPC

## setup the environment

```bash

export AWS_ACCESS_KEY_ID=
export AWS_SECRET_ACCESS_KEY=
export AWS_DEFAULT_REGION=us-east-1

```

## create VPC

```terraform

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

```

## create two subnets

### public subnet

```terraform

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

```

#### Internet Gateway

```terraform

# create the internet gateway
resource "aws_internet_gateway" "my_igw" {
    # get the newly created vpc id
    vpc_id = aws_vpc.my_vpc.id

    # set the tags
    tags = {
        Name = "my_igw"
    }
}

# associate the internet gateway with the vpc
resource "aws_vpc_attachment" "my_vpc_attachment" {
    # get the newly created vpc id
    vpc_id       = aws_vpc.my_vpc.id

    # attach the internet gateway
    internet_gateway_id = aws_internet_gateway.my_igw.id
}

```

#### route table (public)

```terraform

# create a route table
resource "aws_route_table" "public_route_table" {
    # get the newly created vpc id
    vpc_id = aws_vpc.my_vpc.id

    # set the tags
    tags = {
        Name = "my_route_table"
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


```

#### associate the route table with public subnet

```terraform

# associate the route table with the public subnet
resource "aws_route_table_association" "public_subnet_association" {

    # get the newly created route table id
    subnet_id      = aws_subnet.public_subnet.id

    # get the newly created route table id
    route_table_id = aws_route_table.public_route_table.id
}

```

#### create a security group

```terraform

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
}

```

#### ec2 instance (public / jump box)

```terraform
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

```

### private subnet

```terraform

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

```

#### route table private (private)

```terraform

# create a private route table
resource "aws_route_table" "private_route_table" {
    # get the newly created vpc id
    vpc_id = aws_vpc.my_vpc.id

    # set the tags
    tags = {
        Name = "my_private_route_table"
    }
}

```

#### associate the route table with private subnet

```terraform

# associate the route table with the private subnet
resource "aws_route_table_association" "private_subnet_association" {

    # get the newly created route table id
    subnet_id      = aws_subnet.private_subnet.id

    # get the newly created route table id
    route_table_id = aws_route_table.private_route_table.id
}

```

#### ec2 instance (private)

```terraform

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

```
