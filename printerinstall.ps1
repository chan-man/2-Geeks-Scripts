# Variables for customization
$downloadLink = "https://download.support.xerox.com/pub/drivers/ALC80XX/drivers/win10x64/ar/AltaLinkC80xx_7.76.0.0_PCL6_x64.zip"
$downloadPath = "C:\2Geeks"
$zipFileName = "AltaLinkC80xx_7.76.0.0_PCL6_x64.zip"
$extractFolderName = "AltaLinkC80xx_7.76.0.0_PCL6_x64"
$infFileName = "XeroxAltaLinkC80xx_PCL6.inf"
$driverName = "Xerox AltaLink C8035 V4 PCL6"
$printerName = "Xerox Printer"
$portName = "Copier_IP"
$printerIPAddress = "10.0.1.9"

# Create a folder for the files to be downloaded
New-Item -Path $downloadPath -ItemType Directory

# Download the file and save it to the directory
curl $downloadLink -o "$downloadPath\$zipFileName"

# Unzip the saved .zip file
Expand-Archive -Path "$downloadPath\$zipFileName" -DestinationPath "$downloadPath\$extractFolderName"

# Add the printer driver .inf file to the driver store
pnputil /add-driver "$downloadPath\$extractFolderName\$infFileName"

# Add the printer driver to the computer
Add-PrinterDriver -Name $driverName -InfPath "C:\Windows\System32\DriverStore\FileRepository\$infFileName"

# Add a port to the computer
Add-PrinterPort -Name $portName -PrinterHostAddress $printerIPAddress

# Add the printer
Add-Printer -DriverName $driverName -Name $printerName -PortName $portName