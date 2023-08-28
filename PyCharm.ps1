# Define paths and URLs
$downloadUrl = "https://download.jetbrains.com/python/pycharm-community-2023.2.1.exe?_gl=1*10e6a1l*_ga*OTg0ODA0MjIuMTY5MTk5MzQ3MQ..*_ga_9J976DJZ68*MTY5MjkzNzkxNy40LjEuMTY5MjkzNzkyNS4wLjAuMA..&_ga=2.256931020.61902472.1692937918-98480422.1691993471"
$downloadPath = "$env:USERPROFILE\Downloads\PyCharmInstaller.exe"
$installArgs = "/S /D=`"$env:ProgramFiles\PyCharm`""

# Download PyCharm installer
Invoke-WebRequest -Uri $downloadUrl -OutFile $downloadPath

# Install PyCharm silently
Start-Process -Wait -FilePath $downloadPath -ArgumentList $installArgs

# Clean up downloaded installer
Remove-Item -Path $downloadPath -Force

Write-Host "PyCharm Community Edition has been downloaded and installed silently."
