$bashFile = "create_journal.sh"
$hostName = "one"
$journalFile = "journal.txt"
$localDir = "."
$serverDir = "."

scp $bashFile $hostName":"$serverDir
ssh $hostName "$serverDir $bashScript"
scp $hostName":"$journalFile $localDir
