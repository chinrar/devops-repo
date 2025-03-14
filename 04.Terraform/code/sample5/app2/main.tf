# reference the local module
module "test_module" {
  # module path
  source = "./my_module"
  
  # override module variables
  ubuntu_ami = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  key_name = "my_key"
}