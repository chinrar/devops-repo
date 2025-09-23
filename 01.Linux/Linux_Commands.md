

# Hard Link and Soft link


## Hard Link

In Linux, an inode (“index node”) is a data structure that stores metadata about a file on a filesystem.

Hard link creates a file pointing to same inode

file1 --> inode --> | data block |
             ^
file2  ------^

if we delete any of file say file1, we can still access using file2

command:
ln file file-link-name



## Soft link

file1 ---> inode ---> | data block |

file2 ---> inode ---> | path to file 1|

delete file2, no impact
delete file1, file2 becomes dangling pointer

can create soft linke to directory, can create for file in different file system

command:
ln -s file file-link-name

we can create link to link


## lists files with inode numbers

ls -li output is:

[inode] [type+permissions] [link-count] [owner] [group] [size] [date/time] [name]

131072 drwxr-xr-x  3 user group   4096 Aug 26 22:10  mydir
131073 -rw-r--r--  2 user group   1024 Aug 26 22:12  file1.txt
131074 lrwxrwxrwx  1 user group     11 Aug 26 22:13  link1 -> file1.txt

Link count to see how many hard links point to that inode.

First character of the permission string to tell if it’s a directory (d), file (-), or symlink (l).

Identifying Special Cases

Directory:      First char is d → drwxr-xr-x = directory.
Symbolic Link:  First char is l → lrwxrwxrwx = symlink (shows -> target).
Hard Link Count:

    Regular file: number of hard links to the inode (e.g., 2 means there’s 1 more hard link besides the file name).

    Directory: count = 2 + number of subdirectories
                . counts as 1
                .. counts as 1
                Each subdirectory adds 1.
  

# Archive and Compression

🛠 tar Command Options

-c : Create a new archive.
-x : Extract files from an archive.
-t : List the contents of an archive.
-v : Verbose (show file names as they’re processed).
-f : File name of the archive (must follow this option).

Create an Archive (-cvf)
tar -cvf backup.tar mydir/

Creates an archive named backup.tar of the directory mydir/, printing each file as it’s added.

Extract an Archive (-xvf)
tar -xvf backup.tar

Extracts all files from backup.tar into the current directory.

View Contents (-tvf)
tar -tvf backup.tar

Lists the files inside backup.tar without extracting.

Add -z if you also want gzip compression:

tar -czvf backup.tar.gz mydir/      # create compressed
tar -xzvf backup.tar.gz             # extract compressed




