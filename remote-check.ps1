 # Get device information
$computerName = $env:COMPUTERNAME
$userName = [System.Security.Principal.WindowsIdentity]::GetCurrent().Name
$serialNumber = (Get-CimInstance -ClassName Win32_BIOS).SerialNumber
$hostName = [System.Net.Dns]::GetHostName()

# Check if CrowdStrike agent is installed
$crowdStrikePackage = Get-Package -Name "*CrowdStrike*" -ErrorAction SilentlyContinue
$crowdStrikeInstalled = $null -ne $crowdStrikePackage
$crowdStrikeVersion = if ($crowdStrikeInstalled) { $crowdStrikePackage.Version } else { "Not installed" }

# Check if GlobalProtect agent is installed
$globalProtectPackage = Get-Package -Name "*globalprotect*" -ErrorAction SilentlyContinue
$globalProtectInstalled = $null -ne $globalProtectPackage
$globalProtectVersion = if ($globalProtectInstalled) { $globalProtectPackage.Version } else { "Not installed" }

# Output summary
Write-Output ""
Write-Output "Device Summary:"
Write-Output ""
Write-Output "- Computer Name: $computerName"
Write-Output "- User Name: $userName"
Write-Output "- Serial Number: $serialNumber"
Write-Output "- Host Name: $hostName"
Write-Output ""
Write-Output "- CrowdStrike agent: $crowdStrikeInstalled, Version: $crowdStrikeVersion"
Write-Output "- GlobalProtect agent: $globalProtectInstalled, Version: $globalProtectVersion"


$logFile = "C:\Program Files\Palo Alto Networks\GlobalProtect\pan_gp_event.log"
$searchString = "Portal login completed with address"
$prependText = "- GlobalProtect Portal login completed with:"

$result = Select-String -Path $logFile -Pattern $searchString -Context 0,0 | Select-Object -First 1 | ForEach-Object {
    "$prependText "+ $_.Line.Trim().Substring($_.Line.IndexOf($searchString) + $searchString.Length)
}

$result

Write-Output ""
# Check if device is enrolled in Microsoft Intune
if (Test-Path "C:\ProgramData\Microsoft\IntuneManagementExtension\Logs\IntuneManagementExtension.log") {
Write-Output "- MDM: This device is enrolled in Microsoft Intune."
} else {
Write-Output "- MDM: This device is not enrolled in Microsoft Intune."
}

# Check Bitlocker status
$BitlockerStatus = Get-BitLockerVolume
if ($BitlockerStatus.VolumeStatus -eq "FullyEncrypted") {
Write-Output "- Encrytion: Bitlocker is enabled on this device."
} else {
Write-Output "- Encrytion: Bitlocker is not enabled on this device."
}

Write-Output ""
# Pause the script for user input
Pause 
