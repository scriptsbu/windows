# windows

Password info
--
Invoke-RestMethod -Uri https://github.com/scriptsbu/windows/raw/main/3.bat | Invoke-Expression

Start-Process cd C:\Users\Public\AD_info.bat

del AD_info.bat


NOTES:
--

To Download the script:
--
In terminal, execute the following line to download the script to the Public folder

Invoke-WebRequest -Uri https://github.com/scriptsbu/windows/raw/main/AD_info.bat -OutFile C:\Users\Public\AD_info.bat

Then in terminal once the script is downloaded, you can execute the script with the following line:

Start-Process cd C:\Users\Public\AD_info.bat

Delete the file with the following line:

del AD_info.bat


To run the script from GitHub:
--

Invoke-RestMethod -Uri https://github.com/scriptsbu/windows/raw/main/AD_info.bat | Invoke-Expression
