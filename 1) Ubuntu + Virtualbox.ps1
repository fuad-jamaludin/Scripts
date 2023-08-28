# Define paths
$uncPath = "\\10.65.41.10\spss_24\Murdoch Uni Installer\Scripts\ubuntu-22.04.3-desktop-amd64.iso"  # Replace with the UNC path of the ISO image
$downloadsFolder = Join-Path $env:USERPROFILE "Downloads"
$localDestination = "C:\"

# Copy the ISO image from UNC path to Downloads folder
$destinationInDownloads = Join-Path -Path $downloadsFolder -ChildPath "ubuntu-22.04.3-desktop-amd64.iso"
Copy-Item -Path $uncPath -Destination $destinationInDownloads -Force


Write-Host "ISO image copied from UNC path to Downloads folder."

# Download and install VirtualBox
$virtualBoxUrl = "https://download.virtualbox.org/virtualbox/6.1.44/VirtualBox-6.1.44-156814-Win.exe"
$virtualBoxInstaller = "$env:USERPROFILE\Downloads\VirtualBoxInstaller.exe"
Move-Item -Path $virtualBoxInstaller -Destination "C:\"
Invoke-WebRequest -Uri $virtualBoxUrl -OutFile $virtualBoxInstaller
Start-Process -Wait -FilePath $virtualBoxInstaller -ArgumentList "/silent"

# Set the VM name
$vmName = "Student"

# Set the path to the Ubuntu ISO
$ubuntuIsoPath = "$env:USERPROFILE\Downloads\ubuntu-22.04.3-desktop-amd64.iso"

# Set the disk size in MB (minimum recommended size is 8600 MB for Ubuntu)
$diskSize = 15000  # In MB

# Create the virtual machine
& "C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" createvm --name $vmName --ostype "Ubuntu_64" --register
& "C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" modifyvm $vmName --memory 2048 --vram 128 --acpi on --boot1 dvd --nic1 nat
& "C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" createhd --filename "$env:USERPROFILE\VirtualBox VMs\$vmName\$vmName.vdi" --size $diskSize
& "C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" storagectl $vmName --name "SATA Controller" --add sata --controller IntelAHCI
& "C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" storageattach $vmName --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium "$env:USERPROFILE\VirtualBox VMs\$vmName\$vmName.vdi"
& "C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" storageattach $vmName --storagectl "SATA Controller" --port 1 --device 0 --type dvddrive --medium "$ubuntuIsoPath"

# Start the virtual machine installation
& "C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" startvm $vmName

Write-Host "Ubuntu 22.04.3 installation has started in the virtual machine '$vmName'. Follow the installation process in the VirtualBox window."