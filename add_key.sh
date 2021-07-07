eval "$(ssh-agent -s)"
number = 100
path = "~/.ssh/"
keyname = three
comment = $keyname
ssh-keygen -a $number -t ed25519 -f $path$keyname -C $comment
ssh-add $path$keyname