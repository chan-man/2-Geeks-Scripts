Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Load external functions
. "$PSScriptRoot\Functions\Install-Winget.ps1"
. "$PSScriptRoot\Functions\Install-ChromeOnly.ps1"
. "$PSScriptRoot\Functions\Install-VLCOnly.ps1"

# Form setup
$form = New-Object System.Windows.Forms.Form
$form.Text = "2GR IT Software v2.0"
$form.Size = New-Object System.Drawing.Size(550, 400)
$form.StartPosition = "CenterScreen"
$form.FormBorderStyle = 'FixedDialog'
$form.MaximizeBox = $false

# Progress bar
$ProgressBar = New-Object System.Windows.Forms.ProgressBar
$ProgressBar.Location = New-Object System.Drawing.Point(20, 310)
$ProgressBar.Size = New-Object System.Drawing.Size(500, 20)
$ProgressBar.Style = 'Continuous'
$form.Controls.Add($ProgressBar)

# Log output box
$LogBox = New-Object System.Windows.Forms.TextBox
$LogBox.Multiline = $true
$LogBox.ScrollBars = 'Vertical'
$LogBox.Location = New-Object System.Drawing.Point(20, 210)
$LogBox.Size = New-Object System.Drawing.Size(500, 90)
$LogBox.ReadOnly = $true
$form.Controls.Add($LogBox)

# Column 1 (left)
$btnInstallWinget = New-Object System.Windows.Forms.Button
$btnInstallWinget.Text = "1. Install/Update Winget"
$btnInstallWinget.Size = New-Object System.Drawing.Size(230, 30)
$btnInstallWinget.Location = New-Object System.Drawing.Point(20, 20)
$form.Controls.Add($btnInstallWinget)

$btnChromeOnly = New-Object System.Windows.Forms.Button
$btnChromeOnly.Text = "4. Install Chrome Only"
$btnChromeOnly.Size = New-Object System.Drawing.Size(230, 30)
$btnChromeOnly.Location = New-Object System.Drawing.Point(20, 60)
$form.Controls.Add($btnChromeOnly)

$btnVLCOnly = New-Object System.Windows.Forms.Button
$btnVLCOnly.Text = "5. Install VLC Only"
$btnVLCOnly.Size = New-Object System.Drawing.Size(230, 30)
$btnVLCOnly.Location = New-Object System.Drawing.Point(20, 100)
$form.Controls.Add($btnVLCOnly)

# Column 2 (right)
$btnPlaceholder = New-Object System.Windows.Forms.Button
$btnPlaceholder.Text = "Maintenance Function Placeholder"
$btnPlaceholder.Size = New-Object System.Drawing.Size(230, 30)
$btnPlaceholder.Location = New-Object System.Drawing.Point(270, 20)
$form.Controls.Add($btnPlaceholder)

# Event Handlers
$btnInstallWinget.Add_Click({
    $btnInstallWinget.Enabled = $false
    Start-Job -ScriptBlock {
        param ($pb, $log)
        Install-Winget -ProgressBar $pb -LogBox $log
    } -ArgumentList $ProgressBar, $LogBox | Out-Null
    $btnInstallWinget.Enabled = $true
})

$btnChromeOnly.Add_Click({
    $btnChromeOnly.Enabled = $false
    Start-Job -ScriptBlock {
        param ($pb, $log)
        Install-ChromeOnly -ProgressBar $pb -LogBox $log
    } -ArgumentList $ProgressBar, $LogBox | Out-Null
    $btnChromeOnly.Enabled = $true
})

$btnVLCOnly.Add_Click({
    $btnVLCOnly.Enabled = $false
    Start-Job -ScriptBlock {
        param ($pb, $log)
        Install-VLCOnly -ProgressBar $pb -LogBox $log
    } -ArgumentList $ProgressBar, $LogBox | Out-Null
    $btnVLCOnly.Enabled = $true
})

# Show form
$form.ShowDialog()