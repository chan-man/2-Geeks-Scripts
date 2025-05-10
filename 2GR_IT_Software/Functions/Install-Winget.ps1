function Install-Winget {
    param (
        [System.Windows.Forms.ProgressBar]$ProgressBar,
        [System.Windows.Forms.TextBox]$LogBox
    )

    $ScriptBlock = {
        param ($ProgressBar, $LogBox)

        $LogBox.Invoke({ $_.AppendText("Starting winget installation...`r`n") })
        $ProgressBar.Invoke({ $_.Value = 10 })

        $wingetAppInstallerURL = "https://aka.ms/getwinget"
        $installerPath = "$env:TEMP\Microsoft.DesktopAppInstaller_Installer.msixbundle"

        try {
            $LogBox.Invoke({ $_.AppendText("Downloading App Installer bundle...`r`n") })
            Invoke-WebRequest -Uri $wingetAppInstallerURL -OutFile $installerPath
            $ProgressBar.Invoke({ $_.Value = 40 })

            $LogBox.Invoke({ $_.AppendText("Installing App Installer...`r`n") })
            Add-AppxPackage -Path $installerPath
            $ProgressBar.Invoke({ $_.Value = 80 })

            $LogBox.Invoke({ $_.AppendText("winget installation completed.`r`n") })
            $ProgressBar.Invoke({ $_.Value = 100 })
        } catch {
            $LogBox.Invoke({ $_.AppendText("Error installing winget: $_`r`n") })
            $ProgressBar.Invoke({ $_.Value = 0 })
        }
    }

    Start-Job -ScriptBlock $ScriptBlock -ArgumentList $ProgressBar, $LogBox | Out-Null
}