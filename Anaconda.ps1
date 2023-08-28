# Define variables
$downloadUrl = "https://repo.anaconda.com/archive/Anaconda3-2023.07-2-Windows-x86_64.exe"
$downloadPath = "$env:USERPROFILE\Downloads\AnacondaInstaller.exe"
$installArgs = "/AddToPath=0 /S"

# Download Anaconda installer
Invoke-WebRequest -Uri $downloadUrl -OutFile $downloadPath

# Install Anaconda silently
Start-Process -Wait -FilePath $downloadPath -ArgumentList $installArgs

# Clean up downloaded installer
Remove-Item -Path $downloadPath -Force

Write-Host "Anaconda has been downloaded and installed silently."
