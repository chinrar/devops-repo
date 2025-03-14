# Terraform

## IaC
- Declarative IaC
    You specify what the desired infrastructure state should look like
    - Terraform, CloudFormation
- Imperateive IaC
    You specify how to achieve the desired state through step-by step commnads
    - Ansible, Chef

## Terraform
Terraform uses AWS SDK internally to create resources on AWS.
main.tf -> Terrform -> AWS Provider -> AWS SDK -> AWS Cloud

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
# Go to  registry.terraform.io, search aws, click use provider and copy json to get updated provider version

# Use terraform version command to get terraform version installed on your machine. You can use that version in required_version.

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

# refresh the state of resources. if you modify resources externally.
> terraform refresh

# format syntax, indentations
> terraform fmt

```

## Note on tf files

You can write many files with .tf extensions. No need to import.
Terraform will club all the tf files inside the directory and create a single file.


## terraform blocks

### Terraform Block (terraform)

Configures Terraform settings like required providers and versions.
global settings, mention required versions of terraform and providers, location of state file.

```bash
terraform {
  required_version = ">= 1.0.0"
}
```

### Provider Block (provider)

initializatin of provider. Region and environment management.

```bash
provider "aws" {
  region = "us-east-1"
}
```

### Resource Block (resource)

define and manage individual infrastructure components. Defines the actual infrastructure components (e.g., EC2 instances, S3 buckets).

```bash
resource "aws_instance" "web" {
  ami           = "ami-123456"
  instance_type = "t2.micro"
}
```

### Variable Block (variable)

Declares input variables to make configurations dynamic and reusable.

```bash
variable "instance_type" {
  type = "string"
  default = "t2.micro"
}
```

### Output Block (output)

Displays values after applying the configuration, useful for debugging and automation.

```bash
output "instance_ip" {
  value = aws_instance.web.public_ip
}
```

### Module Block (module)

Allows reusing configurations by encapsulating resources into reusable modules.

```bash
module "network" {
  source = "./network-module"
}
```

### Data Block (data)

Fetches existing resources from the provider instead of creating new ones.

```bash
data "aws_ami" "latest" {
  most_recent = true
  owners      = ["amazon"]
}
```

### Locals Block (locals)

Defines local variables for better readability and reuse within the configuration.

```bash
locals {
  environment = "production"
}
```

### Provisioner Block (provisioner)

Runs scripts or commands on a resource after it's created.

```bash
resource "aws_instance" "web" {
  provisioner "local-exec" {
    command = "echo Instance created!"
  }
}
```

### Dynamic Block (dynamic)

Generates nested configuration blocks dynamically inside a resource.

```bash
resource "aws_security_group" "example" {
  dynamic "ingress" {
    for_each = [80, 443]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}
```






