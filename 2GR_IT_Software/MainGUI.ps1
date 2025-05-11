# File: MainGUI.ps1

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Version
$version = "v1.0.0"

# Admin Rights Check
$currentIdentity = [System.Security.Principal.WindowsIdentity]::GetCurrent()
$principal = New-Object System.Security.Principal.WindowsPrincipal($currentIdentity)
if (-not $principal.IsInRole([System.Security.Principal.WindowsBuiltInRole]::Administrator)) {
    [System.Windows.Forms.MessageBox]::Show(
        "2GR-IT-Software must be run as Administrator.",
        "Permission Denied",
        [System.Windows.Forms.MessageBoxButtons]::OK,
        [System.Windows.Forms.MessageBoxIcon]::Error
    )
    exit
}

# Internet Connectivity Check
$ping = Test-Connection -ComputerName 8.8.8.8 -Count 1 -Quiet -ErrorAction SilentlyContinue
if (-not $ping) {
    [System.Windows.Forms.MessageBox]::Show(
        "No internet connection detected. This tool requires internet access to download software.",
        "Connection Error",
        [System.Windows.Forms.MessageBoxButtons]::OK,
        [System.Windows.Forms.MessageBoxIcon]::Error
    )
    exit
}

# Load Functions
$functionsPath = Join-Path -Path $PSScriptRoot -ChildPath "Functions"
Get-ChildItem -Path $functionsPath -Filter *.ps1 | ForEach-Object { . $_.FullName }

# Form
$form = New-Object System.Windows.Forms.Form
$form.Text = "2GR-IT-Software $version - 2 Geeks Repair"
$form.Size = New-Object System.Drawing.Size(600, 600)
$form.StartPosition = "CenterScreen"
$form.BackColor = [System.Drawing.Color]::White
$form.FormBorderStyle = 'Sizable'

# Logo
$logoPath = Join-Path $PSScriptRoot "3DD764E1-3BB5-41C5-B9F2-1754DC460A7C.jpeg"
if (Test-Path $logoPath) {
    $logoBox = New-Object System.Windows.Forms.PictureBox
    $logoBox.Image = [System.Drawing.Image]::FromFile($logoPath)
    $logoBox.SizeMode = 'Zoom'
    $logoBox.Size = New-Object System.Drawing.Size(180, 100)
    $logoBox.Location = New-Object System.Drawing.Point(400, 10)
    $logoBox.Anchor = 'Top,Right'
    $form.Controls.Add($logoBox)
}

# Header
$header = New-Object System.Windows.Forms.Label
$header.Text = "2 Geeks Repair - Setup Assistant"
$header.Font = New-Object System.Drawing.Font("Segoe UI", 16, [System.Drawing.FontStyle]::Bold)
$header.ForeColor = [System.Drawing.Color]::Black
$header.AutoSize = $true
$header.Location = New-Object System.Drawing.Point(20, 25)
$header.Anchor = 'Top,Left'
$form.Controls.Add($header)

# Log Box
$logBox = New-Object System.Windows.Forms.TextBox
$logBox.Multiline = $true
$logBox.ScrollBars = "Vertical"
$logBox.ReadOnly = $true
$logBox.BackColor = [System.Drawing.Color]::White
$logBox.ForeColor = [System.Drawing.Color]::Black
$logBox.Location = New-Object System.Drawing.Point(20, 390)
$logBox.Size = New-Object System.Drawing.Size(550, 140)
$logBox.Anchor = 'Bottom,Left,Right'
$form.Controls.Add($logBox)

# Progress Bar
$progress = New-Object System.Windows.Forms.ProgressBar
$progress.Location = New-Object System.Drawing.Point(20, 360)
$progress.Size = New-Object System.Drawing.Size(550, 20)
$progress.Style = "Continuous"
$progress.Anchor = 'Bottom,Left,Right'
$form.Controls.Add($progress)

# Buttons
$buttons = @(
    @{ Text = "Install WinGet"; Action = { Install-Winget } },
    @{ Text = "Install WinGet Alt"; Action = { Install-WingetAlternative } },
    @{ Text = "Install Chrome"; Action = { Install-ChromeOnly } },
    @{ Text = "Install VLC"; Action = { Install-VLCOnly } },
    @{ Text = "Install LibreOffice"; Action = { Install-LibreOfficeOnly } },
    @{ Text = "Install All (Chrome+VLC+Libre)"; Action = { Install-CombinedApps } },
    @{ Text = "Empty Recycle Bin"; Action = { Empty-RecycleBin } }
)

$y = 130
foreach ($btn in $buttons) {
    $button = New-Object System.Windows.Forms.Button
    $button.Text = $btn.Text
    $button.Font = New-Object System.Drawing.Font("Segoe UI", 10)
    $button.Size = New-Object System.Drawing.Size(260, 35)
    $button.Location = New-Object System.Drawing.Point(20, $y)
    $button.BackColor = [System.Drawing.Color]::Red
    $button.ForeColor = [System.Drawing.Color]::White
    $button.FlatStyle = 'Flat'
    $button.Anchor = 'Top,Left'
    $button.Add_Click({
        try {
            $progress.Value = 10
            $logBox.AppendText("Starting: $($btn.Text)`r`n")
            & $btn.Action.Invoke()
            $progress.Value = 100
            $logBox.AppendText("Finished: $($btn.Text)`r`n")
        } catch {
            $logBox.AppendText("ERROR: $_`r`n")
        } finally {
            Start-Sleep -Seconds 1
            $progress.Value = 0
        }
    })
    $form.Controls.Add($button)
    $y += 40
}

[void]$form.ShowDialog()
