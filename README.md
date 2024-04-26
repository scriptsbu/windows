# windows

Password info
--

Invoke-WebRequest -Uri https://github.com/scriptsbu/windows/raw/main/AD_info.bat -OutFile C:\Users\Public\AD_info.bat

Start-Process cd C:\Users\Public\AD_info.bat

del AD_info.bat

--

cd C:\Users\Public\

Start-Process cd C:\Users\Public\AD_info.bat

del AD_info.bat
