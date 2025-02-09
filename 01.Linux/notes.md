# deployable package management

- packages
  - application code or executable
  - dependencies (libraries or other packages)
  
- types
  - 2 main sources of linux distributions are redhat and debian
  - red hat (fedora)

    - rpm format (red hat package manager)
    - package manager
      - rpm: offline package manager
      - yum or dnf: online package manager

    ```bash

    # update the yum sources
    > sudo yum update

    # install apache2
    > sudo yum install httpd 
    # appache on redhat is called httpd

    ```

  - debian (Ubuntu)

    - deb format
    - package manager
      - dpkg: offline package manager
      - apt or apt-get or snap: online package manager

    ```bash

    # update the apt sources
    > sudo apt-get update

    # install required application
    > sudo apt-get install htop apache2
    # htop - shows running processes on ubuntu using command htop

    # purge or remove the package
    > sudo apt-get purge apache2
    > sudo apt-get remove apache2

    ```

# service management

- service
  - application which runs in the background
  - does not have any GUI
  - uses daemons to provide the functionality
  - controled by systemd (system daemon)
  - systemd is the first process which starts after the computer boots

```bash

# syntax
> sudo systemctl <operation> <daemon or service>

# get the status of the service
> sudo systemctl status apache2

# start the service
> sudo systemctl start apache2

# restart the service
> sudo systemctl restart apache2

# stop the service
> sudo systemctl stop apache2

# start the service at the time of system boot
> sudo systemctl enable apache2

# disable the service from running at the system boot
> sudo systemctl disable apache2

# check if the apache2 is working
> curl http://locahost
> curl http://127.0.0.1
# curl : console url (browsing website on console)

```
# web server
- apache : web server
  - apache stores index.html inside this dir
    cd /var/www/html/
  - index.html
- nginx is another web service
- ubuntu: by default firewall(ufw - ubuntu firewall) is disabled, fedora:   by default enabled
- firewall-cmd : used to deal with firewall settings

```bash

# add http service in firewall
> sudo firewall-cmd --add-service http --permanent

# reload the firewall settings
> sudo firewall-cmd --reload

# get the list of allowed services
> sudo firewall-cmd --list-services

```

# vim: text editor

```bash

# install vim
> sudo apt-get install vim
> sudo yum install vim
> sudo dnf install vim

```

- mode
  - view mode
    - read only mode
    - default mode
    - escape yy - yank (copy) the current line
    - escape 2y - yank two lines
    - escape dd - delete the current line (cut the line -> keep the contents in memory)
    - escape 2dd - delete two lines (current and the next one)
    - escape p - paste the yanked (copied) line(s)
    - escape u - undo the last step
    - control + r - redo the step
    - escape o - insert a new line below
    - escape G - goto the last line of the document
    - escape gg - goto the first line of the document
    - escape { - goto the previous page
    - escape } - goto the next page
    - escape :set number - show the line numbers
    - escape / - search a text in the current document
      - escape n - search forward
      - escape N - search backward
    - escape w - move to next word
    - escape b - move to the previous word
    - escape $ - goto the last character of the current line
    - escape ^ - goto the first character of the current line
  - insert mode
    - used to write the contents in the file
    - escape + i - to start the insert mode
    - escape :w - write the contents to the disk (save)
    - escape :q - quit from the editor
    - escape :wq - save the contents and quit
    - escape :q! - forcelly quit without saving the contents
  - visual mode
    - escape v: start the visual mode
    - select the portion to copy using left and right arrows and press y
    - escape p - paste the yanked contents
- to open multiple files
  - vim -O <file1> <file2>: open the files vertically
  - vim -o <file1> <file2>: open the files horizontally
  - control ww: used to switch between the files
  - escape :qa! - quit all
- to configure vim with global settings
  - save the settings in ~/.vimrc file
  - ~: home directory of currently logged in use
  - file/directory which starts with . is a hidden file/directory
  - set number -> enable line numbers
  - set tabstop -> set the tab size
  - set expandtab -> convert the tab to space

# bash scriptings

- bash is shell, command interpreter
- script which contains the list of commands which can be executed by bash
- script
    script.sh => 
        date
        hostnamectl
```bash
> bash script.sh

# if you have permission to execute then you can write this to execute
> ./script.sh

> which python3
```
will give you this
/usr/bin/python3

- shebang header
  - tells bash which interpreter to use to execute this file
  - starts with #!   
  - e.g.   
    #!/usr/bin/python3
    
    then you can directly run python file using command
```bash
> ./script.py
# or even without extension, extension does not matter in linux
> ./script
```

# common commands

- hostnamectl: get information about the host
- curl: console url (browsing website on console)
- ifconfig: to get the ip related information
- ip: used to get the ip related information
  - ip address show
  - ip a
- firewall-cmd: used to deal with firewall settings
- > cd ~ : home directory of currently logged in user
- file/directory which starts with . is a hidden file/directory
