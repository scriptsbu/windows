# Check if CrowdStrike agent is installed
$crowdStrikePackage = Get-Package -Name "*CrowdStrike*" -ErrorAction SilentlyContinue
$crowdStrikeInstalled = $null -ne $crowdStrikePackage
$crowdStrikeVersion = if ($crowdStrikeInstalled) { $crowdStrikePackage.Version } else { "Not installed" }

# Check if GlobalProtect agent is installed
$globalProtectPackage = Get-Package -Name "*globalprotect*" -ErrorAction SilentlyContinue
$globalProtectInstalled = $null -ne $globalProtectPackage
$globalProtectVersion = if ($globalProtectInstalled) { $globalProtectPackage.Version } else { "Not installed" }

# Output summary
Write-Output "Device Summary:"
Write-Output "- CrowdStrike agent: $crowdStrikeInstalled, Version: $crowdStrikeVersion"
Write-Output "- GlobalProtect agent: $globalProtectInstalled, Version: $globalProtectVersion"


if (Test-Path "HKLM:\SOFTWARE\Microsoft\Enrollments") {
Write-Output "This device is enrolled in Microsoft Intune."
} else {
Write-Output "This device is not enrolled in Microsoft Intune."
}
$BitlockerStatus = Get-BitLockerVolume
if ($BitlockerStatus.VolumeStatus -eq "FullyEncrypted") {
Write-Output "Bitlocker is enabled on this device."
} else {
Write-Output "Bitlocker is not enabled on this device."
}
PAUSE 
