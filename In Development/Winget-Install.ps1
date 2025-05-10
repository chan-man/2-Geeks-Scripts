Write-Host "Checking for winget..." -ForegroundColor Cyan

# Detection Logic
if (Get-Command winget -ErrorAction SilentlyContinue) {
    Write-Host "Winget is already installed on this system. No action required." -ForegroundColor Green
} else {
    Write-Host "Winget is NOT installed." -ForegroundColor Red
    $choice = Read-Host "Would you like to install Winget now? (Y/N)"

    if ($choice -match '^[Yy]$') {
        # Start Installation
        Write-Host "Starting Winget installation..." -ForegroundColor Yellow

        # Architecture
        $arch = if ([Environment]::Is64BitOperatingSystem) { "x64" } else { "x86" }

        # URLs
        $repo = "https://github.com/microsoft/winget-cli/releases/latest/download"
        $vcLibsUrl = "https://aka.ms/Microsoft.VCLibs.$arch.14.00.Desktop.appx"
        $wingetUrl = "$repo/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle"

        # Temp directory
        $temp = "$env:TEMP\\winget-install"
        New-Item -ItemType Directory -Path $temp -Force | Out-Null

        # Downloads
        Invoke-WebRequest -Uri $vcLibsUrl -OutFile "$temp\\VCLibs.appx"
        Invoke-WebRequest -Uri $wingetUrl -OutFile "$temp\\AppInstaller.msixbundle"

        # Install VCLibs
        Write-Host "Installing VCLibs..." -ForegroundColor Yellow
        Add-AppxPackage -Path "$temp\\VCLibs.appx"

        # Install Winget
        Write-Host "Installing Winget..." -ForegroundColor Yellow
        Add-AppxPackage -Path "$temp\\AppInstaller.msixbundle"

        # Final check
        Start-Sleep -Seconds 3
        if (Get-Command winget -ErrorAction SilentlyContinue) {
            Write-Host "Winget installed successfully!" -ForegroundColor Green
        } else {
            Write-Host "Winget installation failed." -ForegroundColor Red
        }

        # Cleanup
        Remove-Item -Recurse -Force $temp
    } else {
        Write-Host "Installation cancelled by user." -ForegroundColor Yellow
    }
}