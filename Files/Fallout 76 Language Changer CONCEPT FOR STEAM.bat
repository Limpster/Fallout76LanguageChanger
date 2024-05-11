@echo off
REM THIS IS A DIFFERENT BAT AND MOST LIKELY NOT THE ONE YOU ARE LOOKING FOR
REM THIS IS A DIFFERENT BAT AND MOST LIKELY NOT THE ONE YOU ARE LOOKING FOR
REM THIS IS A DIFFERENT BAT AND MOST LIKELY NOT THE ONE YOU ARE LOOKING FOR
REM THIS IS A DIFFERENT BAT AND MOST LIKELY NOT THE ONE YOU ARE LOOKING FOR
REM FURTHER CONFIGURATION REQUIRED
REM     - Information
REM This language changer will edit the regional language setting in the Windows registry to a chosen value without altering
REM any formatting (date, currency, etc.), system or input language itself and will revert the language string back to default
REM after your game session has ended.
REM Since Fallout 76 (and maybe other GamepassPC Titles) run only in the language set in the regional language settings of Windows,
REM I thought about making it a hasslefree and easy process without clicking trough the
REM Windows regional settings and reverting them manually after each session.
REM Steam-Users and BethesdaLauncher users might not need this language changer as they can change the language in their respective Launchers (?)

REM     - How do I use this thing?
REM have a look at the Github: https://github.com/Limpster/Fallout76LanguageChanger
REM ADDING THIS BAT TO STEAM IS A LITTLE DIFFERENT COMPARED TO THE INSTRUCTIONS ON THE GITHUB

REM     - Configuration
REM set the language you want to play Fallout 76 in, e.g. en-GB, pt-BR, es-ES, pl-PL, de-DE etc.
REM obviously only languages downloaded and available for your game will work
set "LocaleNew=en-GB"

REM set the UWPHook.exe gameID for Fallout 76 (the ID is unique, one way to optain the id is:
REM after adding the game to steam as non-steam game with UWPHook,
REM create a shortcut to the game via steam
REM (rightlick the game in the library -> manage -> add desktop shortcut),
REM rightclick the desktop shortcut and there you can see the URL steam://rungameid/THIS_IS_THE_ID
set "rungameID=15094346757175246848"

REM set the name of the Fallout 76 executable (in the unlikely case the name of the executable will change, you can edit it here)
REM this is relevant since we are checking if the exectuable is running before we revert the language settings back to default
REM MIGHT BE ANOTHER EXECUTABLE FOR STEAM INSTALLATIONS
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

REM Show the beautiful ASCII-Art Logo and
REM a colored reminder to not close the window while running the game, otherwise it will not set the language back to default
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (2) do rem"') do (
  set "DEL=%%a"
)
ECHO.
call :colorEcho 0c "THIS IS A DIFFERENT BAT-FILE AND MOST LIKELY NOT THE ONE YOU ARE LOOKING FOR"
ECHO.
ECHO     ______      ____  /         __  __________
ECHO    / ____/___ _/ / /_//  __  __/ /_/__  / ___/
ECHO   / /_  / __ `/ / / // \/ / / / __/  / / __ \ 
ECHO  / __/ / /_/ / / / /// / /_/ / /_   / / /_/ /  
ECHO /_/    \____/_/_/\_//_/\____/\__/  /_/\____/ 
ECHO          Language // Changer
ECHO                   /
ECHO.
call :colorEcho 0c "THIS IS A DIFFERENT BAT-FILE AND MOST LIKELY NOT THE ONE YOU ARE LOOKING FOR"
ECHO.
call :colorEcho 0a "Don't close this window while you are running the game!"
ECHO.
REM read the current regional setting (language string) from the registry
for /f "tokens=3" %%i in ('%SystemRoot%\System32\reg.exe query "HKEY_CURRENT_USER\Control Panel\International" /v LocaleName ^| find "LocaleName"') do (
    set "LocaleName=%%i"
)
ECHO default/current language string: %LocaleName%
REM change the region to new locale (configure above)
%SystemRoot%\System32\reg.exe add "HKEY_CURRENT_USER\Control Panel\International" /v LocaleName /d %LocaleNew% /f >nul
ECHO Language changed to %LocaleNew%

REM runs Fallout 76, only works of you configured it as non-steam game with UWPHook and if you entered the correct gameid given by UWPHook (unique)
ECHO starting Fallout 76
start steam://rungameid/%rungameid%"

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
REM this is code to make the colored message above possible
:colorEcho
echo off
<nul set /p ".=%DEL%" > "%~2"
findstr /v /a:%1 /R "^$" "%~2" nul
del "%~2" > nul 2>&1i