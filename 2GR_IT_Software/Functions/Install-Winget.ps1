function Install-Winget {
    param (
        [System.Windows.Forms.ProgressBar]$ProgressBar,
        [System.Windows.Forms.TextBox]$LogBox
    )

    $ProgressBar.Value = 10
    $LogBox.AppendText("Starting Winget installation...`r`n")

    try {
        $url = "https://aka.ms/getwinget"
        $installer = "$env:TEMP\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle"

        Invoke-WebRequest -Uri $url -OutFile $installer -UseBasicParsing
        $ProgressBar.Value = 30
        $LogBox.AppendText("Downloaded Winget installer.`r`n")

        Add-AppxPackage -Path $installer
        $ProgressBar.Value = 70
        $LogBox.AppendText("Winget installed/updated.`r`n")
    } catch {
        $LogBox.AppendText("Error: $_`r`n")
    }

    $ProgressBar.Value = 100
    $LogBox.AppendText("Winget installation complete.`r`n")
}