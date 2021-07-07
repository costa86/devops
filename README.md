# DevOps

## Cheat cheet
### Create SSH-key 
* RSA - The default algorithm

        ssh-keygen

* Ed25519 - The newer and more secure algorithm

        ssh-keygen -o -a <number> -t ed25519 -f ~/.ssh/<key_custom_name> -C "<comment>"

   * "-a" ->  Number of KDF (Key Derivation Function) rounds. Higher numbers result in slower passphrase verification, increasing the resistance to brute-force password cracking should the private-key be stolen. 100 is a good number
   * "-o" -> Saves the private-key using the new OpenSSH format rather than the PEM format. Actually, this option is implied when you specify the key type as ed25519 
   * "-C" -> An identifier. Your email, e.g
   * "-f" -> Specifies the filename of the generated key file. If you want it to be discovered automatically by the SSH agent, it must be stored in the default `.ssh` directory within your home directory.

### Make sure SSH agent is running  
In case you get "Could not open a connection to your authentication agent" error message. 

Also, make sure the SSH agent is running before adding a new key (the `ssh-add` command)

        eval `ssh-agent -s`
        #OR
        eval "$(ssh-agent -s)"
### Add keys

        ssh-add <private_part>
        


### Log into machine

        ssh <user>@<ip>
If you have multiple SSH keys, it's better to specify it, or else you might get an error about failed attempts:

        ssh -i <private_ssh> <user>@<ip>

Extra:
append "-v" at the end to see details of the connection attempt 

### Linux version

        hostnamectl

### Restart SSH service

When some changes are made, such as editing a config.file, e.g. For the changes to kick in.

        systemctl restart sshd
### Check SSH service's status

        systemctl status sshd
### Securely transfer/copy files from LOCAL to SERVER machine

* Single file

        scp -i <ssh_private> <src_file> <user>@<ip>:<target_dir>

* Directory

        scp -r <files_dir> <user>@<ip>:<target_dir>

* Chaining servers (sending files from local machine -> server 1 -> server 2)

         scp <src_file> <user_one>@<ip_one> <user_two>@<ip_two>:<target_dir_two>

### Securely transfer/copy files from SERVER to LOCAL machine

         scp <user>@<ip>:<file_on_server> <destination_on_local>


### Run script in remote machine
From local machine.

Make sure the script is already on the target machine

        ssh <user>@<ip> "<script_location_on_target_machine>"

### Create user

        adduser <user>

### Give sudo permission to user

        usermod -aG sudo <user>

### See user permission

        id <user>

### Copy files & preserve permissions & change ownership

In this example, we make a copy of the current user's .ssh folder into another user

        rsync --archive --chown=<target_user>:<target_user_group> ~/.ssh /home/<target_user>

### Change user

        su <user>
        
### Delete user

        userdel -r <user>

### Get number of existing users
    
        getent passwd | wc -l

### Search for a user
    
        getent passwd | grep <user>

### Copy and paste (helper)

        apt install xclip -y && alias copy="xclip -sel clip" && alias paste="xclip -out -sel clip"


The alias "copy" is equivalent to CTRL + C, and "paste" is equivalent to CTRL + V.

        
        cat <text_file_to_copy_content_from> | copy
        paste


### Update packages on new server

Recommended after creating a new server

        sudo apt update
        sudo apt upgrade

### Disable root login (optional)


Open `etc/ssh/sshd_config` and set the following:

* PermitRootLogin no

* PasswordAuthentication no


### Create a `config` file (very handy!)
It makes it easier to log into remote server machines without needing to type their IP

Use [config](./config) file as a template, and make sure it is placed in `.ssh` folder.
Usage:
                
        ssh <custom_name>

### Edit profile on server machine

`/etc/profile` is executed when the machine starts. It is a good place to set aliases and more commands.


### Monitor accesses to machine (very useful!)


* You can check the contents of `/var/log/auth.log`

* Or you can user Journalctl (more suitable)

[Article about journalctl](https://www.loggly.com/ultimate-guide/using-journalctl/?CMP=KNC-TAD-GGL-SW_EMEA_X_PP_CPC_LD_EN_PROD_SW-LGL-12302661005~119270368524_g_c_-b~497490656865~~20876~~)
        
        journalctl -fu ssh -o json-pretty
        #You can see all kinds of entries as well:
        journalctl

        
  * "-f" -> Follow changes in real time
  * "-u" -> Service/daemon name (`ssh` for debian & ubuntu or `sshd` for other distros)
  * "-o json-pretty" (optional) -> Outputs as JSON (neat!)


### SSH via Android device
You can SSH into server machines using Android mobile apps.
Here, I used JuiceSSH - SSH Client.

* Download: https://play.google.com/store/apps/details?id=com.sonelli.juicessh

* A few actual scheenshots from the app (v3.2.2): [images](./images)

### Copy SSH key from local to server machine
In case SSH auth is not present on the server yet.

This will create `.ssh` folder on the server, along with `authorized_keys` file populated with local's public key

        ssh-copy-id -i <public_key> <user>@<ip>