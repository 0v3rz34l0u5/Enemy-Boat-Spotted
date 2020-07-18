echo off
CHCP 65001
powershell.exe -command "(Invoke-WebRequest https://raw.githubusercontent.com/0verzeal0us/Enemy-Boat-Spotted/Sandstorm/DeleteEBSShortcuts.ps1).content | Out-File -FilePath c:\DeleteEBSSandstormShortcuts.ps1"
powershell.exe –ExecutionPolicy Bypass "c:\DeleteEBSSandstormShortcuts.ps1"
del "c:\DeleteEBSSandstormShortcuts.ps1"
