@echo off

CALL "C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvarsall.bat" amd64

SET GENDEF="C:\ProgramData\MinGW64\MinGW64\bin\gendef.exe"

COPY /Y "C:\Windows\SysWOW64\ntdll.dll" .\ntdll32.dll
%GENDEF% .\ntdll32.dll
lib.exe /def:.\ntdll32.def /out:.\ntdll32.lib /machine:x86
powershell -NoLogo -NoProfile -Command "(Get-Item -Path .\ntdll32.dll).VersionInfo.ProductVersion" > .\ntdll32.version

COPY /Y "C:\Windows\System32\ntdll.dll" .\ntdll64.dll
%GENDEF% .\ntdll64.dll
lib.exe /def:.\ntdll64.def /out:.\ntdll64.lib /machine:x64
powershell -NoLogo -NoProfile -Command "(Get-Item -Path .\ntdll64.dll).VersionInfo.ProductVersion" > .\ntdll64.version

DEL *.def *.exp
