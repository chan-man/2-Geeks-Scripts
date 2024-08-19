#Create folder for files to be downloaded in.
New-Item -Path "C:\2Geeks" -ItemType Directory

#Download the file in the link below and save to the directory below.
curl "https://download.support.xerox.com/pub/drivers/ALC80XX/drivers/win10x64/ar/AltaLinkC80xx_7.76.0.0_PCL6_x64.zip" -o "c:\2Geeks\AltaLinkC80xx_7.76.0.0_PCL6_x64.zip"

#unzip the saved .zip file.
expand-archive -Path "c:\2Geeks\AltaLinkC80xx_7.76.0.0_PCL6_x64.zip" -DestinationPath "c:\2Geeks\AltaLinkC80xx_7.76.0.0_PCL6_x64"

#Add printer driver .inf file to driver store.
pnputil /add-driver "C:\2Geeks\AltaLinkC80xx_7.76.0.0_PCL6_x64\XeroxAltaLinkC80xx_PCL6.inf"

#Add printer driver to computer but replace with your own .inf file name.
add-printerdriver -name "Xerox AltaLink C8035 V4 PCL6" -infpath "C:\Windows\System32\DriverStore\FileRepository\xeroxaltalinkc80xx_pcl6.inf_amd64_1b1bf3ecbf8bc7c5\XeroxAltaLinkC80xx_PCL6.inf

#Add ports to computer but change the port name and port ip address to your own.
Add-PrinterPort -Name "Copier_IP" -PrinterHostAddress "10.0.1.9"

#Final step to add printer but change name to what you want the printer named and use the port name created in the last step.
Add-Printer -DriverName "Xerox AltaLink C8035 V4 PCL6" -Name "Xerox Printer" -PortName "Copier_IP"
