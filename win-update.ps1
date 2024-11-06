ECHO OFF
ECHO "Obtaining IP Address"

ipconfig | findstr /i "ipv4" >NUL 2>NUL
if errorlevel==0 goto ipFound
if errorlevel==1 goto ipNotFound

:ipNotFound
ECHO "IP Address not found."
ipconfig | findstr /i "ipv4"
ECHO "Network not detected, please check your connection and try again."
pause
goto end

:ipFound
ECHO "IP Address Found: "
ipconfig | findstr /i "ipv4"
ECHO(
ECHO(
ECHO "Verifying Available Physical Memory..."
systeminfo | find "Available Physical Memory"
ECHO(
ECHO(
ECHO "Windows 10 Versioning..."
start "" "F:\Windows10Upgrade9252.exe" 
ECHO "Checking for System Updates."
systeminfo | findstr "OS Build: "
ECHO "Please select to continue to Upgrade to Windows 10 22H2 or cancel to continue to Windows 11."
pause
ECHO(
ECHO(
ECHO "Windows 11 Versioning..."
start "" "F:\Windows11InstallationAssistant.exe" 
systeminfo | findstr "OS Build: "
ECHO "Please select to continue to Upgrade to Windows 11 or cancel in the external window."
pause
ECHO(
ECHO(
goto windowsUpdate

:windowsUpdate
ECHO "Checking for System Updates."
Cscript WindowsUpdates2.vbs
ECHO(
ECHO(
goto end


:end
ECHO "Finishing Script..."
systeminfo | findstr "OS Build: "
ECHO(
ECHO(
ECHO "Thank you for using the Windows Update Script. Please exit or move onto other scripts"
