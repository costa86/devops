$number = 100
$path = "C:\Users\lcosta\.ssh\"
$keyname = "win-two"
$comment = $keyname
ssh-keygen -a $number -t ed25519 -f $path$keyname -C $comment
ssh-add $path$keyname