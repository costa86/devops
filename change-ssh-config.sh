file=/etc/ssh/sshd_config

sed -i "s/#PasswordAuthentication yes/PasswordAuthentication no/" $file
sed -i "s/PasswordAuthentication yes/PasswordAuthentication no/" $file

sed -i "s/#PermitRootLogin yes/PermitRootLogin no/" $file
sed -i "s/PermitRootLogin yes/PermitRootLogin no/" $file

systemctl restart sshd