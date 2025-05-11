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

Write-Log "Starting to empty Recycle Bin..."

try {
    Update-Progress 25

    # Use shell COM object to clear recycle bin
    $shell = New-Object -ComObject Shell.Application
    $recycleBin = $shell.Namespace(0xA)
    $recycleBin.Items() | ForEach-Object {
        $_.InvokeVerb("delete")
    }

    Update-Progress 75
    Write-Log "Recycle Bin emptied successfully."
}
catch {
    Write-Log "Error while emptying Recycle Bin: $_"
}
finally {
    Update-Progress 100
    Start-Sleep -Seconds 1
    Update-Progress 0
    Write-Log "Operation complete."
}