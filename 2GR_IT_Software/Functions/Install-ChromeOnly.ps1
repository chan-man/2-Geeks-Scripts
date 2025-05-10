function Install-ChromeOnly {
    param (
        [System.Windows.Forms.ProgressBar]$ProgressBar,
        [System.Windows.Forms.TextBox]$LogBox
    )

    $ProgressBar.Value = 10
    $LogBox.AppendText("Starting Chrome install...`r`n")

    try {
        $chromeUrl = "https://dl.google.com/chrome/install/latest/chrome_installer.exe"
        $chromeInstaller = "$env:TEMP\chrome_installer.exe"

        Invoke-WebRequest -Uri $chromeUrl -OutFile $chromeInstaller -UseBasicParsing
        $ProgressBar.Value = 40
        $LogBox.AppendText("Chrome installer downloaded.`r`n")

        Start-Process -FilePath $chromeInstaller -ArgumentList "/silent /install" -Wait
        $ProgressBar.Value = 90
        $LogBox.AppendText("Chrome installed.`r`n")
    } catch {
        $LogBox.AppendText("Error: $_`r`n")
    }

    $ProgressBar.Value = 100
    $LogBox.AppendText("Chrome installation complete.`r`n")
}