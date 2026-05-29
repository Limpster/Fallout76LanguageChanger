@echo off
chcp 65001 >nul
REM Instruction that switches the console’s active code page to UTF‑8, so Unicode characters (like the star ★) can display correctly

setlocal EnableExtensions EnableDelayedExpansion
REM Fallout 76 Language Changer (Microsoft Store)
REM 	About
REM For the most recent information visit: https://github.com/Limpster/Fallout76LanguageChanger
REM A simple way to change your windows region back and forth,
REM allowing Fallout 76 (and maybe some other GamePass-PC titles/titles depending on windows region settings) to run in a supported language of choice.
REM This is just a batch-file to change the language, launch the game and revert the changes afterwards.
REM This script has been tested for the Gamepass/MS-Store Version of the game.
REM Might not be of use for Steam/Bethesdalauncher users.
REM This script does not modify system UI language, input language, or formatting
REM (date, currency, etc.); it only changes the LocaleName registry value.

REM 	Configuration
REM Make the required changes in the configuration below and double click the bat file, that's it!
REM more in-depth information can be found here: https://github.com/Limpster/Fallout76LanguageChanger

REM Desired game language, e.g. en-GB, en-US, de-DE, es-ES, es-419, fr, it, ja, pl-PL, pt-BR, ru, zh-CN, zhTW
REM obviously only languages downloaded and available for your game will work
REM default: en-GB
set "LocaleNew=en-GB"

REM Path to the Fallout 76 Game Pass executable, required to start the game with the launcher
REM default: C:\XboxGames\Fallout 76\Content\Project76_GamePass.exe
set "Path_to_Fallout76_Gamepass.exe=C:\XboxGames\Fallout 76\Content\Project76_GamePass.exe"

REM Fallout 76 executable name (used for process checks)
REM set the name of the Fallout 76 executable (in the unlikely case the name of the executable will change, you can edit it here)
REM this is relevant since we are checking if the executable is running before we revert the language settings back to default
REM default: Project76_GamePass.exe
set "Fallout_executable=Project76_GamePass.exe"

REM Run mode
REM (recommended: close)
REM - close = changes language and reverts to the original system language shortly after game processes are detected running, then exits the script (game stays open)
REM so you don't have to keep the script running, usually it doesn't matter if your game crashes/powerloss etc.

REM - wait  = changes language and waits until GamingServicesUI and Fallout 76 close, then revert to original system language and exit the script
REM you have to keep the script running, if your game or PC crashes, the language will not be reverted to default; use restore (see below) in case of crash
REM e.g. set "run_mode=close"
set "run_mode=close"

REM Restore-only (crash recovery):
REM - 1 = set LocaleName to restore_target and exit (no game launch)
REM - 0 = run normally according to run_mode
set "restore_only=0"

REM Target language for restore-only mode (e.g., your preferred system language like de-DE or en-US)
REM e.g. "restore_target=de-DE" (will set windows locale to de-DE)
set "restore_target="

REM Timing options
REM - timeout_seconds: delay for wait-mode termination checks; closes the script after X amound of seconds in wait mode after game processes are terminated.
REM - max_wait_seconds: max time to wait for both processes to appear in close-mode.
REM - grace_seconds: delay after detection in close-mode before reverting LocaleName; reverts language to system default after game process has been found, then closes the script.
set "timeout_seconds=5" REM default 5
set "max_wait_seconds=120" REM default 120
set "grace_seconds=5" REM default 10

REM Close-mode: close GamingServicesUI after reverting (1=yes, 0=no)
set "close_gamingservicesui=1"
REM End of configuration
 
REM		Troubleshooting
REM If your default settings didn't get reverted to your default language because
REM you accidently closed the language changer window or your PC crashed you can always reset it by
REM a) use the "restore only" feature of this tool (see above)
REM b) changing your regional settings in the corresponding menu in Windows
REM c) run "%SystemRoot%\System32\reg.exe add "HKEY_CURRENT_USER\Control Panel\International" /v LocaleName /d %LocaleName% /f"
REM (where %LocaleName% has to be replaced by your locale, e.g. de-DE) in your Terminal/Run-Command/Commandline
REM d) edit registry by hand (see https://github.com/Limpster/Fallout76LanguageChanger)

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
REM some shameless self-promotion
ECHO If you enjoy this tool, have a look at my Github and leave a ★ Thank you^^!
ECHO https://github.com/Limpster/Fallout76LanguageChanger
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (
  set "DEL=%%a"
)
call :colorEcho 0A "Do not close this window!"
ECHO.

REM read the current regional setting (language string) from the registry, used for later
for /f "tokens=3" %%i in ('
  %SystemRoot%\System32\reg.exe query "HKEY_CURRENT_USER\Control Panel\International" /v LocaleName ^| find "LocaleName"
') do set "LocaleName=%%i"
REM print the current language string
echo Default/current language: %LocaleName%

REM Restore-only branch (crash recovery)
if "%restore_only%"=="1" goto RESTORE_ONLY

REM Preflight checks and launch
if not exist "%Path_to_Fallout76_Gamepass.exe%" (
  echo Error: Could not find the game executable at the specified path.
  pause
  exit /b 2
)

REM Set desired LocaleName (configured above) before launching the game
%SystemRoot%\System32\reg.exe add "HKEY_CURRENT_USER\Control Panel\International" /v LocaleName /d %LocaleNew% /f >nul
echo Language changed to %LocaleNew%.

REM Launch Fallout 76
echo Starting Fallout 76...
start "" "%Path_to_Fallout76_Gamepass.exe%"

REM Decide behavior
if /I "%run_mode%"=="close" goto CLOSE_MODE
if /I "%run_mode%"=="wait"  goto WAIT_MODE

REM Fallback: default to wait mode if misconfigured; double check for typos in the configuration in case there is an error
echo Warning: Unknown run_mode value "%run_mode%". Falling back to wait mode...
goto WAIT_MODE

REM CLOSE MODE (recommended): revert soon after both processes are running (game stays open, script window closes itself)
:CLOSE_MODE
echo Waiting for GamingServicesUI to start...
set /a waited_gs=0
:close_wait_gsui
timeout /t 1 /nobreak >nul
tasklist /fi "imagename eq gamingservicesui.exe" | find /i "gamingservicesui.exe" >nul
if errorlevel 1 (
  set /a waited_gs+=1
  if !waited_gs! lss %max_wait_seconds% goto close_wait_gsui
  echo Timed out waiting for GamingServicesUI to start.
)

echo Waiting for Fallout 76 to start...
set /a waited_fx=0
:close_wait_game
timeout /t 1 /nobreak >nul
tasklist /fi "imagename eq %Fallout_executable%" | find /i "%Fallout_executable%" >nul
if errorlevel 1 (
  set /a waited_fx+=1
  if !waited_fx! lss %max_wait_seconds% goto close_wait_game
  echo Timed out waiting for Fallout 76 to start.
)

if %grace_seconds% gtr 0 (
  echo Waiting %grace_seconds% seconds before reverting language...
  timeout /t %grace_seconds% /nobreak >nul
)

REM Revert to original LocaleName
%SystemRoot%\System32\reg.exe add "HKEY_CURRENT_USER\Control Panel\International" /v LocaleName /d %LocaleName% /f >nul
echo Language reverted to %LocaleName%.

REM Optionally close GamingServicesUI after revert (config above)
if "%close_gamingservicesui%"=="1" (
  taskkill /im gamingservicesui.exe /t /f >nul 2>&1
)

echo Exiting.
exit /b 0

REM WAIT MODE: wait until the apps close, then revert and exit
:WAIT_MODE
echo Waiting for GamingServicesUI to close...
:WAIT_FOR_GAMINGSERVICESUI
timeout /t %timeout_seconds% /nobreak >nul
tasklist /fi "imagename eq gamingservicesui.exe" | find /i "gamingservicesui.exe" >nul
if %errorlevel% equ 0 goto WAIT_FOR_GAMINGSERVICESUI

echo Waiting for Fallout 76 to close...
:WAIT_FOR_FALLOUT76
timeout /t %timeout_seconds% /nobreak >nul
tasklist /fi "imagename eq %Fallout_executable%" | find /i "%Fallout_executable%" >nul
if %errorlevel% equ 0 goto WAIT_FOR_FALLOUT76

REM Revert to original LocaleName after both have closed
%SystemRoot%\System32\reg.exe add "HKEY_CURRENT_USER\Control Panel\International" /v LocaleName /d %LocaleName% /f >nul
echo Language reverted to %LocaleName%.
echo Exiting.
exit /b 0

REM RESTORE-ONLY: set a chosen language and exit (game won't launch)
:RESTORE_ONLY
if not defined restore_target (
  echo restore_only=1 but no restore_target set. Nothing changed.
  exit /b 1
)
echo Setting LocaleName to %restore_target% ...
%SystemRoot%\System32\reg.exe add "HKEY_CURRENT_USER\Control Panel\International" /v LocaleName /d %restore_target% /f
echo Done. Exiting.
exit /b 0

REM this is code to make the colored message above possible
:colorEcho
echo off
<nul set /p ".=%DEL%" > "%~2"
findstr /v /a:%1 /R "^$" "%~2" nul
del "%~2" > nul 2>&1
goto :eof
