@ECHO OFF
cls
ECHO read current regional setting language from registry
%SystemRoot%\System32\reg.exe query "HKEY_CURRENT_USER\Control Panel\International" /v LocaleName /s
pause