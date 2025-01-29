#Backup Cleanup Variables
$BackupDirectory = "$env:USERPROFILE\AppData\Roaming\Apple Computer\MobileSync"
$BackupDirectory1 = "$env:USERPROFILE\Apple\MobileSync"
$BackupFolder = "Backup"

#Backup folder delete and recreate
cd $BackupDirectory
Remove-Item -Path $BackupFolder -Recurse -Force
New-Item -Path $BackupFolder
cd $BackupDirectory1
Remove-Item -Path $BackupFolder -Recurse -Force
New-Item -Path $BackupFolder
