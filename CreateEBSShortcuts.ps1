## Gets the location of Steam depending on CPU architecture
$cpu = (Get-WMIObject Win32_Processor).AddressWidth
if ($cpu -eq 64) {
        $regSteamKey = "HKLM:\SOFTWARE\WOW6432Node\Valve\Steam" }
    else {
        $regSteamKey = "HKLM:\SOFTWARE\Valve\Steam"
}
$steamInstallDir = Get-ItemProperty -path "$regSteamKey" -name "InstallPath"
$steamFolder = $steamInstallDir.InstallPath
## Gets location of the Insurgency Sandstorm icon file (to make the shortcut look pretty).  
$insurgencySandstormIconFile = Get-ItemProperty -path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Steam App 581320\' -name "DisplayIcon"
$iconFile = $insurgencySandstormIconFile.DisplayIcon
## Gets install location of the Insurgency Sandstorm (the batch file(s) will be created here).
$insurgencySandstormInstallDir = Get-ItemProperty -path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Steam App 581320\' -name "InstallLocation"
$insurgencySandstormFolder = $insurgencySandstormInstallDir.InstallLocation
## The following (which is currently disabled as there are now two servers) will scrape the IP address and port number from the forum. 
## $url = "http://enemyboat.co.uk/viewtopic.php?f=10&t=321&sid=b9be412d4ca5d6d0258379e913fee469#p2737" 
## $data = Invoke-WebRequest -Uri $url 
## $forumPost = $data.ParsedHtml.body.getElementsByTagName('div') | Where {$_.getAttributeNode('class').Value -eq 'codebox'}
## $codeBox = $forumpost.innerText[1]
## $stripServerAddress = ($codeBox | Select-String -Pattern "\d{1,3}(\.\d{1,3}){3}:\d{1,5}" -AllMatches).Matches.Value
##
## Creates a shortcut for the co-op server
$coopBatchFileName = "ebscoopserver.bat"
$coopbatchFile = "$($insurgencySandstormFolder)\$($coopBatchFileName)"
$WriteCMDList = @"
echo off
set steamFolder=$steamFolder
set serverIPandPort=164.132.118.71:7777
cd %steamFolder%
cmd.exe /c echo %serverIPandPort%|clip
steam.exe -applaunch 581320
"@ 
$WriteCMDList | Out-File -FilePath $coopBatchFile -Encoding ASCII
$WshShell = New-Object -ComObject WScript.Shell
$startMenuFolder = "Microsoft\Windows\Start Menu\Programs"
$coopShortcutFilename = "EBS Co-Op Insurgency Sandstorm Server.lnk"
$coopShortcutFile = "$($env:APPDATA)\$($startMenuFolder)\$($coopShortcutFilename)"
$coopShortcut = $WshShell.CreateShortcut($coopShortcutFile)
$coopShortcut.TargetPath = $coopbatchFile
$coopShortcut.IconLocation = "$($iconFile),0"
$coopShortcut.Save()
$pvpBatchFileName = "ebspvpserver.bat"
$pvpbatchFile = "$($insurgencySandstormFolder)\$($pvpBatchFileName)"
$WriteCMDList = @"
echo off
set steamFolder=$steamFolder
set serverIPandPort=178.32.157.60:27102
cd %steamFolder%
cmd.exe /c echo %serverIPandPort%|clip
steam.exe -applaunch 581320
"@ 
$WriteCMDList | Out-File -FilePath $pvpBatchFile -Encoding ASCII
$WshShell = New-Object -ComObject WScript.Shell
$pvpShortcutFilename = "EBS PVP Insurgency Sandstorm Server.lnk"
$pvpShortcutFile = "$($env:APPDATA)\$($startMenuFolder)\$($pvpShortcutFilename)"
$pvpShortcut = $WshShell.CreateShortcut($pvpShortcutFile)
$pvpShortcut.TargetPath = $pvpBatchFile
$pvpShortcut.IconLocation = "$($iconFile),0"
$pvpShortcut.Save()
