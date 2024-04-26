Powershell Scripts
--
Password Info: Invoke-RestMethod -Uri https://github.com/scriptsbu/windows/raw/main/AD_info.bat | Invoke-Expression


NOTES:
--

To Download the script:
--
In Powershell, execute the following line to download the script to the Public folder:

Invoke-WebRequest -Uri https://github.com/scriptsbu/windows/raw/main/AD_info.bat -OutFile C:\Users\Public\AD_info.bat

Then in Powershell once the script is downloaded, you can execute the script with the following line:

Start-Process cd C:\Users\Public\AD_info.bat

Delete the file with the following line:

del AD_info.bat

or:

Invoke-WebRequest -Uri https://github.com/scriptsbu/windows/raw/main/AD_info.bat -OutFile C:\Users\Public\AD_info.bat | Start-Process cd C:\Users\Public\AD_info.bat | del AD_info.bat


To run the script from GitHub:
--

Invoke-RestMethod -Uri https://github.com/scriptsbu/windows/raw/main/AD_info.bat | Invoke-Expression
