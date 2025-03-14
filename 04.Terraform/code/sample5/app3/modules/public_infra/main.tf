# create public subnet
resource "aws_subnet" "public_subnet" {
    # get the newly created vpc id
    vpc_id     = var.vpc_id

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
    vpc_id = var.vpc_id

    # set the tags
    tags = {
        Name = "my_igw"
    }
}


# create a route table
resource "aws_route_table" "public_route_table" {
    # get the newly created vpc id
    vpc_id = var.vpc_id

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
    vpc_security_group_ids = [var.security_group_id]

    # set the tags
    tags = {
      Name = "public_ec2"
    }
}
