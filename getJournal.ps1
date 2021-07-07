$bashScript = "create_journal.sh"
$hostName = "one"
$separator = ":"
$journalFile = "journal.txt"
$localDir = "."

scp $bashScript $hostName$separator
ssh $hostName " . $bashScript"
scp $hostName$separator$journalFile $localDir
