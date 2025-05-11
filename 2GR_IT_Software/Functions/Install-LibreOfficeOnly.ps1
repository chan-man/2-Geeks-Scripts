param (
    [System.Windows.Forms.TextBox]$LogBox,
    [System.Windows.Forms.TextBox]$ProgressBar
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

Write-Log "Starting LibreOffice installation..."
Update-Progress 10

try {
    # Ensure winget is available
    if (-not (Get-Command "winget" -ErrorAction SilentlyContinue)) {
        Write-Log "winget is not installed or not in PATH."
        throw "Missing winget."
    }

    Update-Progress 30
    Write-Log "Installing LibreOffice..."

    Start-Process "winget" -ArgumentList 'install --id=TheDocumentFoundation.LibreOffice --silent --accept-source-agreements --accept-package-agreements' -Wait -NoNewWindow

    Update-Progress 90
    Write-Log "LibreOffice installation complete."
}
catch {
    Write-Log "Error during LibreOffice installation: $_"
}
finally {
    Update-Progress 100
    Start-Sleep -Seconds 1
    Update-Progress 0
    Write-Log "Operation complete."
}