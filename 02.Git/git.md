# Git

## installation

```bash

# update the apt repo
> sudo apt-get update

# install git
> sudo apt-get install git

# on windows
# https://git-scm.com/downloads/win

```

## first time configuration

```bash

# set the user name
> git config --global user.name "Amit"

# set the email for the user
> git config --global user.email "pythoncpp@gmail.com"

# Config levels
# local -> repository level
# global -> user level, stored in user’s home dir ~/.gitconfig
# system -> OS level

```

## basic workflow

```bash

# initialize a repository
> git init

# get the status of working directory
> git status

# get the status of working directory in one line (short status)
> git status -s

# statuses
# first letter: status of a file with respect to the staging area
# second letter: status of a file with respect to the working directory
# ??: the file is not yet committed in the repository
# A : the file is present in the staging area and will be added to the repository when committed
#  M: the file is modified and is present in the working directory
# M : the file is modified and is added to the staging area
# UU: the file has got at least one conflict

# conflict
# the file is modified by both the branches on the same line
# in which scenario, git can not handle merging the changes

# add the changes to the staging area
# git add <file(s) with changes>
# git add . : add all the files which are changed in the current directory
# > git ady myfile
> git add .

# commit the changes
# > git commit -m <message>
> git commit -m "first commit"

# get the logs
> git log

# get the logs
# --oneline: shows only one line log info
# --graph: render the commit graph
# --color: enable color while rendering the commit graph
> git log --oneline --graph --color

# get the difference between the current and previous version of all updated files
# +: the line is added to the file
# -: the file is deleted from the file
> git diff

# get the difference between the current and previous version of selected file
# > git diff <file name>
> git diff myfile

# replace the last version with current version
# > git checkout <filename>
> git checkout myfile

# remove all the changes from staging area and move them to the working directory
# this command will not remove the changes, but only move from staging to working directory
> git reset

# hard reset
# - all the changes (from working directory and staging area) will be removed
# - once removed there is no way to get them back
# note: please execute this command on your own risk
> git reset --hard


```

## git internals

- git init command creates a repository (directory named .git)
- .git directory contains
  - HEAD
    - file which has an entry of current branch
  - branches
  - config
    - file contains the local repository configuration
    - the configuration here is restricted only for the current repository
  - description
    - description about the repository
  - hooks
    - contains the scripts to be executed on different events
    - the scripts can be written in any language or even shell scripts
  - info
  - objects
    - object file stores the encrypted metadata (file contents or commit info etc)
    - every object (file) has a unique identifier (40 bytes)
    - out of 40 bytes
      - first 2 bytes are used to create a directory
      - remaining 38 bytes are used to create a file to store the contents of a file
    - git used SHA algorithm to get the hash of the object
    - types
      - blob
        - object file which stores the contents of a file in encrypted format
        - gets created per file
      - tree
        - object file which contains the mappings of blob object files with their respective file names
        - object gets create per directory
      - commit
        - object file which stores the commit information
        - contains
          - author details
          - committer details
          - unix timestamp
          - commit message
          - parent object id
    - root commit object
      - this type of commit object will get created only once (first time)
      - this commit object does not contain the parent object id
  - refs

```bash

# find the type of the object
# -t: type of an object
# > git cat-file -t <object id>

# get the readable contents of an object
# -p: pretty print the contents
# > git cat-file -p <object id>

# delete all unwanted objects and create pack files
# gc: garbage collection
> git gc

# watch the progress
> cd .git
> rm hooks/*
> watch -n 1 tree .

```

## branches

- is simply reference to a latest commit object

```bash

# get the list of branches
> git branch

# create a new branch
# the new branch will have same commit id as that of the current branch
# > git branch <branch name>
> git branch branch1

# switch to other branch
# > git checkout <branch name>
> git checkout branch1

# create a new branch and checkout immediately
# > git checkout -b <branch name>
> git checkout -b branch2

# merge the changes from one branch to another branch
# note: first checkout the branch in which you want to merge another branch
> git checkout master
# > git merge <branch name>
> git merge branch1

# squash merge
# - collect all the commit objects of second branch and turn them into a single object
# - then the single commit object gets merged in the source branch
# - this will help git to reduce the commit history/tree/graph
> git merge --squash

# delete a branch
# > git branch -d <branch name>
> git branch -d branch1

# rename a branch
# the current branch will be renamed
# > git branch -M <new branch>
> git branch -M main

```

## stash

```bash

# get the list of changes parked in the stash area
> git stash list

# stash the changes
# move the changes from working directory to stash area
# > git stash
# > git stash save <message>
> git stash save "algo1"

# get the details of a stash entry
# > git stash show <stash id>
> git stash show stash@{0}

# apply the changes from stash area to working directory
# > git stash apply <stash id>
> git stash apply stash@{1}

# delete the stash object
# > git stash drop <stash id>
> git stash drop stash@{0}

# apply and drop the last commit from the stash area
# git stash pop = git stash apply + git stash drop
> git stash pop


```

## git remote

```bash

# get the remote repo details
> git remote -v

# connect the local repo to the remote one
# > git remote add <alias> <remote repo url>

# remove the remote from repository
# > git remote remove <alias>
> git remote remove origin

# get the repository contents for the first time
# > git clone <git repository url>
> git clone https://github.com/pythoncpp/application1.git

# generate ssh keys (private and public)
# public key: used for encryption
# private key: used for decryption
# this command will create keys under ~/.ssh directory
> ssh-keygen

# git push <remote-alias> <branch>
> git push origin master
 
# first time when there’s no branch in remote
# then you have to set upstream
> git push -u origin master

# next time onwards you can simply do
> git push

```
