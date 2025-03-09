# Terraform

## installation on Ubuntu

```bash

# download the key to access hashicorp apt source
> wget -O - https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg

# add the hashicorp apt source
> echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list

# update the apt cache
> sudo apt update

# install terraform
> sudo apt install terraform

# check if terraform is installed
> terraform version

```

## installation on macOS

```bash

# add brew source
> brew tap hashicorp/tap

# install terraform
> brew install hashicorp/tap/terraform

```

## configure AWS CLI

```bash

# open the bashrc file
> vim ~/.bashrc

# add the following configuration
> export AWS_ACCESS_KEY_ID=
> export AWS_SECRET_ACCESS_KEY=
> export AWS_DEFAULT_REGION=

# North Virginia - us-east-1
# Mumbai - ap-south-1

# load the settings in the same terminal
> source ~/.bashrc

# confirm if the access key is properly configured
> echo $AWS_ACCESS_KEY_ID
> echo $AWS_SECRET_ACCESS_KEY

```

## configure the VS

```bash

# https://marketplace.visualstudio.com/items?itemName=HashiCorp.terraform

```

## test the settings

```terraform
# go to terraform registry, search aws, click use provider and copy json to get updated provider version

terraform {
    required_version = ">= 1.0.0"
    required_providers {
      aws={
        source = "hashicorp/aws"
        version = "5.82.2"
      }
    }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "web-server" {
  ami           = "ami-0e2c8caa4b6378d8c"
  instance_type = "t2.micro"
  key_name      = "key-demops"
  tags = {
    Name = "Web Server"
  }
}


```

## perform the operations

```bash

# download required providers
> terraform init

# check if the configuration is valid
> terraform validate

# get the plan of execution
> terraform plan

# create the infra using terraform
> terraform apply

# Destroy the infra using terraform
> terraform destroy

# refresh the state of resources
> terraform refresh

```
