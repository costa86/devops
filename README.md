# DevOps

## Cheat cheet
* Create ssh-key

        ssh-keygen
    
* Add key

        ssh-add <private_part>

* Log into machine

        ssh <user>@<ip>
        #If you have multiple ssh keys, it's better to specify it, or else you might get an error about failed attempts:
        ssh -i <private_ssh> <user>@<ip>
        #extra:
        append "-v" at the end to see details of the connection attempt 

* Linux version

        hostnamectl

* Copy files into another machine

        scp -i <ssh_private> <src_file> <user>@<ip>:<target_dir>

* Log into machine and run script (already on the target machine)

        ssh <user>@<ip> "<script_location_on_target_machine>"

* Create user

        adduser <user>

* Give sudo permission to user

        usermod -aG sudo <user>

* See user permission

        id <user>

* Copy files & preserve permissions & change ownership

    In this example, we copy current user's .ssh folder into the user

        rsync --archive --chown=<user>:<group> ~/.ssh /home/<user>

* Change user

        su <user>

* Get number of existing users
    
        getent passwd | wc -l

* Search for a user
    
        getent passwd | grep <user>

* Copy and paste

        apt install xclip
        alias copy="xclip -sel clip"
        alias paste="xclip -out -sel clip"
        #Usage
        #"copy" is equivalent to ctrl + c
        cat <text_file> | copy
        #now paste it
        paste

* Update packages on new server

        sudo apt update
        sudo apt upgrade

* Disable root login

        nano /etc/ssh/sshd_config

        #Set the following:
        #PermitRootLogin no
        #PasswordAuthentication no

* Start `ssh-agent` ("Could not open a connection to your authentication agent" error message
)

        eval `ssh-agent -s`

* Create a `config` file to easily log into remote machines, without needing to type their IP

Use [config](./config) file as a template, and make sure it is placed in `.ssh` folder.
                
        ssh <custom_host_name>

* Edit profile on server machine

This file is executed when the machine starts. It is a good place to set aliases and more commands.

        nano /etc/profile