# Define paths and URLs
$downloadUrl = "https://public-cdn.cloud.unity3d.com/hub/prod/UnityHubSetup.exe"
$downloadPath = "$env:USERPROFILE\Downloads\UnityHubSetup.exe"
$installArgs = "/S /D=`"$env:ProgramFiles\Unity Hub`""

# Download Unity Hub installer
Invoke-WebRequest -Uri $downloadUrl -OutFile $downloadPath

# Install Unity Hub silently and wait for the installation to finish
Start-Process -Wait -FilePath $downloadPath -ArgumentList $installArgs


Write-Host "Unity Hub has been downloaded and installed silently."

# Prompt the user to press Enter before closing
Read-Host -Prompt "Press Enter to exit..."
