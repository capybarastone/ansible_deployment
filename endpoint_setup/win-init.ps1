## Script used to intitialize test environment setup on windows
# To Use: As Admin do - "wget -Uri https://raw.githubusercontent.com/capybarastone/ansible_deployment/refs/heads/main/endpoint_setup/win-init.ps1 -Outfile .\win-init.ps1", then ".\win-init.ps1"

# Install OpenSSH Server for Windows host
Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0
Start-Service sshd
Set-Service -Name sshd -StartupType 'Automatic'

# Set PowerShell to be default shell on Windows for ansible
Set-ItemProperty "HKLM:\Software\Microsoft\Powershell\1\ShellIds" -Name ConsolePrompting -Value $true
New-ItemProperty -Path HKLM:\SOFTWARE\OpenSSH -Name DefaultShell -Value "C\Windows\System32\WindowsPowerShell\v1.0\powershell.exe" -PropertyType String -Force
