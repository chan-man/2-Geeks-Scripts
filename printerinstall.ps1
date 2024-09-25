# Variables for customization
$downloadLink = "https://download.support.xerox.com/pub/drivers/GLOBALPRINTDRIVER/drivers/win10x64/ar/UNIV_5.1009.1.0_PCL6_x64.zip"
$downloadPath = "C:\2Geeks"
$zipFileName = "UNIV_5.1009.1.0_PCL6_x64.zip"
$extractFolderName = "UNIV_5.1009.1.0_PCL6_x64"
$infFileName = "x3UNIVX.inf"
$driverName = "Xerox Global Print Driver PCL6"
# Driver location is the name of the folder in the File Repository where the driver INF file is located.
$driverLocation = "x3univx.inf_amd64_da1d17edb334b897"
$printerName = "Xerox Printer"
$portName = "Copier_IP"
$printerIPAddress = "192.168.100.50"

# Create a folder for the files to be downloaded
New-Item -Path $downloadPath -ItemType Directory

# Download the file and save it to the directory
curl $downloadLink -o "$downloadPath\$zipFileName"

# Unzip the saved .zip file
Expand-Archive -Path "$downloadPath\$zipFileName" -DestinationPath "$downloadPath\$extractFolderName"

# Add the printer driver .inf file to the driver store
pnputil /add-driver "$downloadPath\$extractFolderName\$infFileName" /subdirs

# Add the printer driver to the computer
Add-PrinterDriver -Name $driverName -InfPath "C:\Windows\System32\DriverStore\FileRepository\$driverLocation\$infFileName"

# Add a port to the computer
Add-PrinterPort -Name $portName -PrinterHostAddress $printerIPAddress

# Add the printer
Add-Printer -DriverName $driverName -Name $printerName -PortName $portName

# Remove the Zip file downloaded
Remove-Item "$downloadPath\$zipFileName" -Recurse

# Remove the extracted folder downloaded
Remove-Item "$downloadPath\$extractFolderName" -Recurse