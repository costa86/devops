# DevOps

## Cheat cheet
* Create ssh-key

        ssh-keygen
    
* Add key

        ssh-add <private_part>

* Log into machine

        ssh <user>@<ip>

* Linux version

        hostnamectl

* Copy files into another machine

        scp <file> <user>@<ip>:<target_dir>

* Log into machine and run script (already on the target machine)

        ssh <user>@<ip> ". <script.sh>"

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

* Update packages on new server

        sudo apt update
        sudo apt upgrade

* Disable root login

        nano /etc/ssh/sshd_config

        #Set the following:
        #PermitRootLogin no
        #PasswordAuthentication no