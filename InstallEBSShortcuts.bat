echo off
CHCP 65001
powershell.exe -command "(Invoke-WebRequest https://raw.githubusercontent.com/0v3rz34l0u5/Enemy-Boat-Spotted/Sandstorm/CreateEBSShortcuts.ps1).content | Out-File -FilePath c:\CreateEBSSandstormShortcuts.ps1"
powershell.exe –ExecutionPolicy Bypass "c:\CreateEBSSandstormShortcuts.ps1"
del "c:\CreateEBSSandstormShortcuts.ps1"

