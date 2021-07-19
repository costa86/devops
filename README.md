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

#### :warning: About the passphrase
When creating a SSH key, you will be prompted for an optional passphrase that will be required when you try to use it. Before choosing whether you want it,  let's consider the following scenario:
* We have ``key A``- generated on machine 1 and connects machine 1 to machine 2
* The private part of ``key A`` gets leaked! :fearful:
* Someone tries to use the leaked ``key A`` on their machine and attempts a connection to machine 2
* If ``key A`` has no passphrase, the connection will very likely work! :scream:
* On the other hand, if a passphrase was set, it will be prompted at the moment someone tries to add it to their machine (the ``ssh-add`` command). Therefore they will not even be able to try to use it for connecting to machine 2
  
#### Remove passphrase

        ssh-keygen -p -f <private_key>

### About the files in ``/.ssd`` folder
 ``authorized_keys``
 Contains public keys for machines authorized to SSH connect into the current machine. Add/remove entries here to allow/deny access from other machines.
                
:warning: If you use the command below, make sure you use ``>>`` (will append to) and not ``>`` (will override)!

        echo <new_public_key> >> authorized_keys

``known_hosts``
"Remembers" the machines that the current machine has previously connected to. Every time you connect to a new machine, its fingerprint will be saved here (and you will be notified of that). It is a mechanism to verify that  the machine you are connecting to is actually the one you think it is.
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

### Find current machine's public IP

* Local command

        
        ifconfig

* Web service

        curl ifconfig.co/json
        #"/json" is optional, and returns:
        {
                "ip": "167.71.35.9",
                "ip_decimal": 2806457097,
                "country": "Germany",
                "country_iso": "DE",
                "country_eu": true,
                "region_name": "Hesse",
                "region_code": "HE",
                "zip_code": "60313",
                "city": "Frankfurt am Main",
                "latitude": 50.1188,
                "longitude": 8.6843,
                "time_zone": "Europe/Berlin",
                "asn": "AS14061",
                "asn_org": "DIGITALOCEAN-ASN",
                "user_agent": {
                "product": "curl",
                "version": "7.68.0",
                "raw_value": "curl/7.68.0"
                }
        }
### Restart SSH service

When some changes are made, such as editing a config file, e.g. For the changes to kick in:

        systemctl restart sshd
### Check SSH service's status

        systemctl status sshd
### Securely transfer/copy files from LOCAL to SERVER machine

* Single file

        scp -i <ssh_private> <src_file> <user>@<ip>:<target_dir>

* Directory

        scp -r <files_dir> <user>@<ip>:<target_dir>

* "Chaining" servers 
  Let's say the ``local`` machine connects to ``server 1`` only, and ``server 1`` connects to ``server 2`` only. 
  Here's how we can send files from ``local`` to ``server 2``, by using ``server 1`` as a middleman:
        
  * 1/2 Send file from ``local`` to  ``server 1``

                scp <src_file> <user_one>@<ip_one>:<temp_dir>
   
   * 2/2 Now, having the file on ``server 1``, send it to ``server 2`` (from ``local``)
     
                scp <user_one>@<ip_one>:<src_file> <user_two>@<ip_two>:<final_dir>
  
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

### Add passphrase to SSH key

        ssh-keygen -p -f <private_key>

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

        apt install xclip -y
        alias copy="xclip -sel clip"
        alias paste="xclip -out -sel clip"


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
It makes it easier to SSH connect to remote server machines without needing to type their IP.

Use [config](./config) file as a template, and make sure it is placed in `/.ssh` folder.
Once this file is set, the SSH connections can be made as such:
                
        ssh <custom_name>

### Edit profile on server machine

The file `/etc/profile` is executed when the machine starts. It is a good place to set aliases and more commands.

Example: alias c=clear


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

This will create `/.ssh` folder on the server, along with `authorized_keys` file populated with local's public key

        ssh-copy-id -i <public_key> <user>@<ip>

## Scripts (``PowerShell`` and ``Bash``)
In this project there are scripts to automate some tasks related to the concepts explained above:

### Create user
``create-user.sh``
Creates a new user, gives it ``sudo`` permissions, and copies ``./ssd`` folder from ``root`` to the new user created, enabling the server machine to accept SSH connections using the new user 
  
### Log generator
``create-journal.sh``
Generates a log file containing entries registered on a remote machine (requires root access)
### Log collector
``get-journal.ps1``
Receives the log generated by``create-journal.sh``
  
### Create and add SSH key
``add-key.sh`` and ``add-key.ps1``
Creates and adds new Ed25519 SSH key
  
### Make changes to SSH config file
``change-ssh-config.sh``
Searches and replaces strings in ``/etc/ssh/sshd_config``. 
Some examples of replacements to make:
* Disable root access: ``PermitRootLogin no``
* Disable authentication via password: ``PasswordAuthentication no``  
