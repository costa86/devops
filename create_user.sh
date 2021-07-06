user=normal
group=$user
adduser $user
usermod -aG sudo $user
rsync --archive --chown=$user:$group ~/.ssh /home/$user
su $user
cd $home
#rm ./create_user.sh
