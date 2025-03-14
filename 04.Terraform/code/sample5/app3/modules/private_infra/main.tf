# create the private subnet
resource "aws_subnet" "private_subnet" {
    # get the newly created vpc id
    vpc_id     = var.vpc_id

    # cidr block for public subnet
    cidr_block = var.private_subnet_cidr

    # set the tags
    tags = {
        Name = "private_subnet"
    }
}

# create a private route table
resource "aws_route_table" "private_route_table" {
    # get the newly created vpc id
    vpc_id = var.vpc_id

    # set the tags
    tags = {
        Name = "my_private_route_table"
    }
}


# associate the route table with the private subnet
resource "aws_route_table_association" "private_subnet_association" {

    # get the newly created route table id
    subnet_id      = aws_subnet.private_subnet.id

    # get the newly created route table id
    route_table_id = aws_route_table.private_route_table.id
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
    vpc_security_group_ids = [var.security_group_id]

    # set the tags
    tags = {
      Name = "private_ec2"
    }
}