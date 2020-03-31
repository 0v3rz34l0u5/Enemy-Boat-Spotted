$cpu = (Get-WMIObject Win32_Processor).AddressWidth
if ($cpu -eq 64) {
        $regSteamKey = "HKLM:\SOFTWARE\WOW6432Node\Valve\Steam" }
    else {
        $regSteamKey = "HKLM:\SOFTWARE\Valve\Steam"
}
$steamInstallDir = Get-ItemProperty -path "$regSteamKey" -name "InstallPath"
$steamFolder = $steamInstallDir.InstallPath
## Gets install location of the Insurgency Sandstorm (the batch file(s) will be created here).
$insurgencySandstormInstallDir = Get-ItemProperty -path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Steam App 581320\' -name "InstallLocation"
$insurgencySandstormFolder = $insurgencySandstormInstallDir.InstallLocation
$coopBatchFileName = "ebscoopserver.bat"
$pvpBatchFileName = "ebspvpserver.bat"
$startMenuFolder = "Microsoft\Windows\Start Menu\Programs"
$coopShortcutFilename = "EBS Co-Op Insurgency Sandstorm Server.lnk"
$coopShortcutFile = "$($env:APPDATA)\$($startMenuFolder)\$($coopShortcutFilename)"
$pvpShortcutFilename = "EBS PVP Insurgency Sandstorm Server.lnk"
$pvpShortcutFile = "$($env:APPDATA)\$($startMenuFolder)\$($pvpShortcutFilename)"
del "$insurgencySandstormFolder\$coopBatchFileName"
del "$insurgencySandstormFolder\$pvpBatchFileName"
del "$coopShortcutFile"
del "$pvpShortcutFile"