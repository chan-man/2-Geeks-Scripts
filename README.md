# Printer-Install-Script
This PowerShell script is for automating the install of a mass number of printers.

It can do the following so far:
1. Create a folder for the files to be donwloaded in.
2. Download the driver file from a link provided.
3. If the link is a .zip file it unzips the file and places it in the folder created earlier.
4. Adds the print driver .inf file to the driver store.
5. Adds the printer driverto the computer to be used.
6. Adds an IP address port to the computer and allows a custom name for that port to be set.
7. Compiles the data above to install the printer fully and add a custom name to the printer.

This is the order in which the program runs and completes it's script as well.
