$IPSWDirectory = "$env:USERPROFILE\AppData", "C:\3uToolsV3"
$fileExtension = "*.ipsw"
$files = Get-ChildItem -Path $IPSWDirectory -Recurse -File -Filter "$fileExtension"

Foreach ($file in $files) {

Write-Host "IPSW-Files: $($file.FullName)"
Remove-Item -Path $file -Force
}