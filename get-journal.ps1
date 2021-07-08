$bashFile = "create-journal.sh"
$hostName = "ubu-2"
$journalFile = "journal.txt"

scp $bashFile $hostName":"$serverDir
ssh $hostName ". $bashScript"
scp $hostName":"$journalFile "."
