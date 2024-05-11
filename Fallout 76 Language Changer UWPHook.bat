@echo off
REM     - Information
REM This language changer will edit the regional language setting in the Windows registry to a chosen value without altering
REM any formatting (date, currency, etc.), system or input language itself and will revert the language string back to default
REM after your game session has ended.
REM Since Fallout 76 (and maybe other GamepassPC Titles) run only in the language set in the regional language settings of Windows,
REM I thought about making it a hasslefree and easy process without clicking trough the
REM Windows regional settings and reverting them manually after each session.
REM Steam-Users and BethesdaLauncher users might not need this language changer as they can change the language in their respective Launchers (?)

REM     - How do I use this thing?
REM Make the required changes in the configuration below and double click the bat file, that's it!

REM     - Configuration
REM set the language you want to play Fallout 76 in, e.g. en-GB, pt-BR, es-ES, pl-PL, de-DE etc.
REM obviously only languages downloaded and available for your game will work
set "LocaleNew=en-GB"

REM set path to UWPHook.exe
set "path_to_UWPHook.exe=C:/PATH/TO/UWPHook.exe"

REM set the UWPHook.exe AUMID/AppID for Fallout 76 (in case the ID will change, you can edit it here)
set "AUMID=BethesdaSoftworks.Fallout76-PC_3275kfvn8vcwc!Fallout76"

REM set the name of the Fallout 76 executable (in the unlikely case the name of the executable will change, you can edit it here)
REM this is relevant since we are checking if the exectuable is running before we revert the language settings back to default
set "Fallout_executable=Project76_GamePass.exe"
REM     - End of configuration

REM     - Troubeshooting
REM If your default setting didn't get reverted toy your default because
REM you accidently closed the language changer window or your PC crashed
REM you can always reset it by going into your regional settings in Windows
REM and selecting your region or run
REM %SystemRoot%\System32\reg.exe add "HKEY_CURRENT_USER\Control Panel\International" /v LocaleName /d %LocaleName% /f
REM (where %LocaleName% has to be replaced by your locale, e.g. de-DE)
REM in your Terminal/Run-Command/Commandline

REM Show the beautiful ASCII-Art Logo

ECHO.
ECHO     ______      ____  /         __  __________
ECHO    / ____/___ _/ / /_//  __  __/ /_/__  / ___/
ECHO   / /_  / __ `/ / / // \/ / / / __/  / / __ \ 
ECHO  / __/ / /_/ / / / /// / /_/ / /_   / / /_/ /  
ECHO /_/    \____/_/_/\_//_/\____/\__/  /_/\____/ 
ECHO          Language // Changer
ECHO                   /
ECHO.
REM some self-promotion
ECHO If you enjoy this tool, have a look at my Github and leave a star, thank you!
ECHO https://github.com/Limpster/Fallout76LanguageChanger
REM a colored reminder to not close the window while running the game, otherwise it will not set the language back to default
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (
  set "DEL=%%a"
)
call :colorEcho 0a "Don't close this window while you are running the game!"
REM this is code to make the colored message above possible
:colorEcho
echo off
<nul set /p ".=%DEL%" > "%~2"
findstr /v /a:%1 /R "^$" "%~2" nul
del "%~2" > nul 2>&1i
ECHO.
REM read the current regional setting (language string) from the registry
for /f "tokens=3" %%i in ('%SystemRoot%\System32\reg.exe query "HKEY_CURRENT_USER\Control Panel\International" /v LocaleName ^| find "LocaleName"') do (
    set "LocaleName=%%i"
)
ECHO default/current language string: %LocaleName%
REM change the region to new locale (configure above)
%SystemRoot%\System32\reg.exe add "HKEY_CURRENT_USER\Control Panel\International" /v LocaleName /d %LocaleNew% /f >nul
ECHO Language changed to %LocaleNew%

REM run Fallout 76 from Gamepass/UWP App with UWPHook.exe (configure path above)
ECHO starting Fallout 76
start "" "%path_to_UWPHook.exe%" %AUMID% %Fallout_executable%

REM waiting for termination of Fallout 76 and gamingservicesui with a timeout of 5 seconds
REM as soon as the service and the Fallout executable are terminated, the language will be reverted to system default
REM and the window will close itself
ECHO GamingservicesUI is running
:WAIT_FOR_GamingServicesUI
timeout /t 5 /nobreak >nul
tasklist | find /i "gamingservicesui.exe" >nul
if %errorlevel% equ 0 (
    goto WAIT_FOR_GamingServicesUI
)
ECHO Fallout 76 is running
:WAIT_FOR_FALLOUT76
timeout /t 5 /nobreak >nul
tasklist | find /i "%Fallout_executable%" >nul
if %errorlevel% equ 0 (
    goto WAIT_FOR_FALLOUT76
)
REM if Fallout 76 and gamingservicesui are terminated, change language back to system default
REM change the region to the default language string read out from registry above
%SystemRoot%\System32\reg.exe add "HKEY_CURRENT_USER\Control Panel\International" /v LocaleName /d %LocaleName% /f
ECHO Language changed back to %LocaleName%
REM the language changer will exit automatically after the regional language has been set back to default
exit
