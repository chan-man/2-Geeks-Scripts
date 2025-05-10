function Install-VLCOnly {
    param (
        [System.Windows.Forms.ProgressBar]$ProgressBar,
        [System.Windows.Forms.TextBox]$LogBox
    )

    $ProgressBar.Value = 10
    $LogBox.AppendText("Starting VLC install...`r`n")

    try {
        $vlcUrl = "https://get.videolan.org/vlc/3.0.20/win64/vlc-3.0.20-win64.exe"
        $vlcInstaller = "$env:TEMP\vlc_installer.exe"

        Invoke-WebRequest -Uri $vlcUrl -OutFile $vlcInstaller -UseBasicParsing
        $ProgressBar.Value = 40
        $LogBox.AppendText("VLC installer downloaded.`r`n")

        Start-Process -FilePath $vlcInstaller -ArgumentList "/S" -Wait
        $ProgressBar.Value = 90
        $LogBox.AppendText("VLC installed.`r`n")
    } catch {
        $LogBox.AppendText("Error: $_`r`n")
    }

    $ProgressBar.Value = 100
    $LogBox.AppendText("VLC installation complete.`r`n")
}