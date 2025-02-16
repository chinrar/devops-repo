# install apache

```bash

# connect to the ec2 instance
# usernames
# - ubuntu: ubuntu server AMI
# - ec2-user: Amazon Linux (Centos based image)
# - Administrator: Windows
# > ssh -i <pem file path> <username>@<public ip of ec2 instance>

# update the apt cache
> sudo apt-get update

# install apache
> sudo apt-get install apache2

# check the status of the apache2 service
> sudo systemctl status apache2

# start the apache service
> sudo systemctl start apache2

# enable the service to run after reboot automatically
> sudo systemctl enable apache2

# upload the file(s) from your machine to the ec2 instance
# > scp -i <pem file path> <source file> <user>@<public ip address>:<destination path>
> scp -i ~/Downloads/key-demops.pem index.html ubuntu@18.206.171.237:/tmp/

# copy the file to the apache's web root directory
> sudo mv /tmp/index.html /var/www/html/

# Upload multiple files by archiving them
> tar -cvf website.tar *
> scp -i ~/Downloads/key-demops.pem website.tar ubuntu@18.206.171.237:/tmp/
> cd /var/www/html/
> sudo mv /tmp/website.tar .
> sudo tar -xvf website.tar

# reboot ec2 in ssh session
> sudo reboot

# How to ssh into private instance from public instance
# Public instance used for this purpose is called jump box
# You cannot store key for private instance in public instance that will give everyone access to private instance. Instead, you cache the key for private instance on your local machine. Forward that cached key to public instance while doing ssh into it then from public instance, ssh to private instance using cached key.

# cache the key
> ssh-add devops-key.pem

# forward all the cached keys (to public instance)
> ssh -A -i devops-key.pem ubuntu@183.23.123.12

# form public instance, ssh to private instance using cached key
> ssh -A ubuntu@123.12.123.23

```
