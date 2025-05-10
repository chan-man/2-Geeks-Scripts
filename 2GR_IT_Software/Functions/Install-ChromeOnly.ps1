param (
    [System.Windows.Controls.TextBox]$LogBox,
    [System.Windows.Controls.ProgressBar]$ProgressBar
)

function Write-Log {
    param($Message)
    $LogBox.Dispatcher.Invoke([action]{
        $LogBox.AppendText("[$(Get-Date -Format 'HH:mm:ss')] $Message`n")
        $LogBox.ScrollToEnd()
    })
}

function Update-Progress {
    param($Value)
    $ProgressBar.Dispatcher.Invoke([action]{
        $ProgressBar.Value = $Value
    })
}

Write-Log "Starting Chrome installation..."

try {
    Update-Progress 10
    Write-Log "Checking for Winget availability..."

    if (Get-Command winget -ErrorAction SilentlyContinue) {
        Update-Progress 25
        Write-Log "Winget found. Installing Chrome..."

        $wingetResult = Start-Process -FilePath "winget" -ArgumentList "install --id=Google.Chrome -e --accept-package-agreements --accept-source-agreements" -Wait -PassThru -NoNewWindow

        if ($wingetResult.ExitCode -eq 0) {
            Update-Progress 90
            Write-Log "Chrome installed successfully via Winget."
        } else {
            Write-Log "Winget installation failed with exit code $($wingetResult.ExitCode)."
        }
    } else {
        Write-Log "Winget is not available. Cannot install Chrome."
    }
}
catch {
    Write-Log "An error occurred: $_"
}
finally {
    Update-Progress 100
    Write-Log "Chrome installation process complete."
    Start-Sleep -Seconds 2
    Update-Progress 0
}