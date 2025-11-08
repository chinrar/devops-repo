
## Basic commands related to user

> whoami

current logged in user

> id amitk

user information

> useradd
> sudo useradd -m user1

create new user

> sudo -i

login with root user

> cd ~

home directory of current user

> passwd

change password of current user

> sudo passwd user1

change passsword of user1

> userdel

delete user



## Group

Collection of users sharing permissions to resource/file.

group  --> group name and group id

Types --
    Primary Group
        - Every user has exactly one primary group, it is mandatory
        - This group will own files created by that user
        - when you create new user, linux adds new group with same name
    Supplementary Group
        - user may be a memeber of one or more supplementary group
        - /etc/group
              docker:x:1000:amitk,jenkins
              group name, password, group id, members 
        
groupadd
> sudo groupadd group1

groupdel
lid  : show list of users

> sudo usermod -aG docker user1

add user1 to docker group


## permissions

Every file protected with 3 permissions
r/w/x

user owner      - r/w/x
group owner     - r/w/x
others          - r/w/x

user    primary suppementary
----------------------------
user1 -> user1  group1
uesr2 -> user2  group1
user3 -> user3

user1 create a file file1.txt

> ls -l file1.txt   //permissions with user1 as logged in user

-rw-rw-r--

for file1.txt
user onwer is user1    
group owner will be user1's primary group (user1)

> su user2

user2 will get other permission : r--
user2 is not part of user1 group
user2 can only read file1.txt
same case for user3

> sudo usermod -aG user1 user2

Changing supplementary group of user2
now user2 can now update file1.txt

> sudo usermod -g user1 user3

changed primary group of user3 to user1

> chmod o-r file1.txt

remove read from other:o for file1.txt

relative
chmod o-r file1.txt

absolute
read(4),write(2),execute(1)
rwx = 4+2+1 = 7
rw- = 4+2 = 6
r-- = 4
--- = 0

> chmod 600 file1.txt

chmod can only be done by owner user and root

> ls -l file1.txt

-rw------- 1 user1 user1 size date/time name

> chown user1:group1 file1.txt

Changing both owner and group owner of file
Changing user owner to other user can be done by root user only.

> chgrp group1 file1.txt

changing group owner of file












