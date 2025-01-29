#IPSW Cleanup Variables
$IPSWDirectory = "$env:USERPROFILE\AppData\Roaming\Apple Computer\iTunes"
$iPadFolder = "iPad Software Updates"
$iPhoneFolder = "iPhone Software Updates"

#Backup Cleanup Variables
$BackupDirectory = "$env:USERPROFILE\AppData\Roaming\Apple Computer\MobileSync"
$BackupDirectory1 = "$env:USERPROFILE\Apple\MobileSync"
$BackupFolder = "Backup"

#IPSW Delete IPSW files folders and recreate them.
cd $IPSWDirectory
Remove-Item -Path $iPhoneFolder, $iPadFolder -Recurse -Force
New-Item -Path $iPhoneFolder, $iPadFolder

#Backup folder delete and recreate
cd $BackupDirectory
Remove-Item -Path $BackupFolder -Recurse -Force
New-Item -Path $BackupFolder
cd $BackupDirectory1
Remove-Item -Path $BackupFolder -Recurse -Force
New-Item -Path $BackupFolder
