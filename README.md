# Fallout76LanguageChanger
A simple and semi-automatic way to change your windows region forth and back, allowing Fallout 76 (and maybe some other GamePass-PC titles) to run in a chosen language

## Information
This language changer will edit the regional language setting in the Windows registry to a chosen value without altering any formatting (date, currency, etc.), system or input language itself and will revert the language string back to default after your game session has ended.
Since Fallout 76 (and maybe other GamepassPC Titles) run only in the language set in the regional language settings of Windows, I thought about making it a hasslefree and easy process without clicking trough the Windows regional settings and reverting them manually after each session.
Steam-Users and BethesdaLauncher users might not need this language changer as they can change the language in their respective Launchers as far as I know (since I don't own the Steam/Bethesda Launcher Version, I am not able to help users with these launchers)

## Requirements
You will have the best experience with this language changer if you are using the 
* Gamepass Version of Fallout 76
* Windows 11 (will probably work with other/older/newer versions, but has only been tested on Windows 11 23H2 22635.3495 for the time being)
* UWPHook (to launch the game via the bat-file)

If you don't want to use the language changer and just want to change the region a little easier other than clicking through the windows settings, you will find more information below, explaining other -still easy- solutions for this matter.

## How do I use this thing?
Make the required changes in the configuration inside of the bat-file, save your changes and double click the bat file, that's it!

## Configuration
You will find a few settings inside the bat-file which you have to edit, they are all explained (some with examples) in the file and in this readme.
Set the language you want to play Fallout 76 in, e.g. en-GB, pt-BR, es-ES, pl-PL, de-DE etc. (obviously only languages downloaded and available for your game will work, I tested it with en-GB, pt-BR, es-ES, pl-PL and de-DE) 
example for english language: `set "LocaleNew=en-GB"`

Since I am launching the Game with UWPHook through Steam and not trough the regular shortcut or the XBOX/Gamepass App, I have to tell the file, where to find UWPHook.exe to launch Fallout 76.
Edit this setting to set the path to UWPHook.exe  
example: `set "path_to_UWPHook.exe=C:/PATH/TO/UWPHook.exe"`

I guess that the AUMID/APPID will remain the same, unless they release some kind of new version for the game, anyhow, here you are able to edit the AUMID/APPID in the unlikely case of a change. UWPHook.exe shows the ID, you can also easily copy it after adding a shortcut to Steam with UWPHook.
set the UWPHook.exe AUMID/AppID for Fallout 76 (in case the ID will change, you can edit it here) 
`set "AUMID=BethesdaSoftworks.Fallout76-PC_3275kfvn8vcwc!Fallout76"`

The same goes for the Fallout 76 executable, in the unlikely case the name of the executable will change, you can edit it here.
This is relevant since we are checking if the exectuable is running before we revert the language settings back to default 
`set "Fallout_executable=Project76_GamePass.exe"`

## Troubeshooting
If your default setting didn't get reverted toy your default because you accidently closed the language changer window or your PC crashed you can always reset it by going into your regional settings in Windows and selecting your region or run
`"%SystemRoot%\System32\reg.exe add "HKEY_CURRENT_USER\Control Panel\International" /v LocaleName /d %LocaleName% /f"` (where %LocaleName% has to be replaced by your locale, e.g. de-DE) in your Terminal/Run-Command/Commandline.
