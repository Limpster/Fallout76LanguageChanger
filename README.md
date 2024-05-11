# Fallout76LanguageChanger
A simple and semi-automatic way to change your windows region forth and back, allowing Fallout 76 (and maybe some other GamePass-PC titles) to run in a chosen language.

## Information
Got Fallout 76 for Gamepass and I wanted to play it in english, unfortunately there is no setting to change the localisation in the Game or via a Launcher. After some google-fu I always read the same (mostly not working) solutions (changing the whole regional setting for Windows manually which also changes date/time, currency etc., changing the whole system language, changing Gamepass/Store country in your Microsoft account, even using VPN etc.[[1]](https://www.reddit.com/r/fo76/comments/xxnhcr/changing_the_language_settings_microsoft_store/), [[2]](https://www.reddit.com/r/fo76/comments/q20su1/how_to_change_game_language_fallout_76_gamepass/), [[3]](https://answers.microsoft.com/en-us/xbox/forum/all/fallout-76-change-the-language/f5eb011d-92f3-4428-96a6-e4dc0f2f2422) which sounded a little over the top or wasn't working at all and I couldn't find a simple and easy solution.<br>Now, the game is out since quite a few years and somehow I coulnd't believe that my approach might work because it is actually too simple, but here we are.<br>
This language changer will edit the regional language setting in the Windows registry to a chosen value without altering any formatting (date, currency, etc.), system or input language itself and will revert the language string back to default after your game session has ended. **Only the String for "LocaleName" will be changed**, all the currency, date/time and formatting settings will remain the same.<br>
Since Fallout 76 (and maybe other GamepassPC Titles, e.g. Forza 4 seem to have the same "problem") run only in the language set in the regional language settings of Windows, I thought about making it a hasslefree and easy process without clicking trough the Windows regional settings and reverting them manually after each session.<br><br>
> Steam-Users and BethesdaLauncher users **might** not need this language changer as they can change the language in their respective launchers as far as I know (since I don't own the Steam/Bethesda Launcher Version, I am not able to help users with these launchers)

I hope this little script helps you to enjoy the game in another language [(also, I heard that some quest with a poem was translated incorrectly and thus it's not working propery for some other languages than english)](https://www.reddit.com/r/fo76/comments/1bq71w7/psa_for_german_language_players_trying_to_solve/)


## Requirements
You will have the best experience with this language changer if you are using the 
* Gamepass Version of Fallout 76
* Windows 11 (will probably work with other/older/newer versions, but has only been tested on Windows 11 23H2 22635.3495 for the time being)
* [UWPHook](https://github.com/BrianLima/UWPHook) (to launch the game via the bat-file), if you don't want to add the game as non-steam game, just extract UWPHook somewhere and configure the path to the UWPHook.exe in the bat-file (see below)

If you don't want to use the language changer and just want to change the region a little easier other than clicking through the windows settings, you will find more information below, explaining other -still easy- solutions for this matter.

## How do I use this thing?
Download the bat-file above, make the required changes in the configuration inside of the bat-file, save your changes and double click the bat file, that's it!
Further options will be explained below.

## Configuration
You will find a few settings inside the bat-file which you have to edit, they are all explained (some with examples) in the file and in this readme.
Set the language you want to play Fallout 76 in, e.g. en-GB, pt-BR, es-ES, pl-PL, de-DE etc. (obviously only languages downloaded and available for your game will work, I tested it with en-GB, pt-BR, es-ES, pl-PL and de-DE)
<br>example for english language: `set "LocaleNew=en-GB"`

Since I am launching the Game with UWPHook through Steam and not trough the regular shortcut or the XBOX/Gamepass App, I have to tell the file, where to find UWPHook.exe to launch Fallout 76.
Edit this setting to set the path to UWPHook.exe<br>
example: `set "path_to_UWPHook.exe=C:/PATH/TO/UWPHook.exe"`

I guess that the AUMID/APPID will remain the same, unless they release some kind of new version for the game, anyhow, here you are able to edit the AUMID/APPID in the unlikely case of a change. UWPHook.exe shows the ID, you can also easily copy it after adding a shortcut to Steam with UWPHook.
set the UWPHook.exe AUMID/AppID for Fallout 76 (in case the ID will change, you can edit it here)<br>
`set "AUMID=BethesdaSoftworks.Fallout76-PC_3275kfvn8vcwc!Fallout76"`

The same goes for the Fallout 76 executable, in the unlikely case the name of the executable will change, you can edit it here.
This is relevant since we are checking if the exectuable is running before we revert the language settings back to default<br>
`set "Fallout_executable=Project76_GamePass.exe"`

## manual approach
If you don't want to run the batch because it doens't fit your needs, your have plenty of options to change the language settings without clicking through the windows settings, I will give you some ideas:
#### - REG-File
  You can create a REG-File which enters the chosen value directly in the registry. Create an empty textfile with an editor of your choice, insert the following code (here: en-GB for english), save it as *.reg file (e.g. english.reg) and doubleclick to make changes to the registry (I added examples to this repo so you can download them straight away)
```
  Windows Registry Editor Version 5.00

[HKEY_CURRENT_USER\Control Panel\International]
"LocaleName"="en-GB"
```
#### - Edit the registry via Terminal/Commandline
  open your Terminal/Commandline and type in the follwing code (here: en-GB for english) and press Enter, the changes will be made to the registry right away!

```
%SystemRoot%\System32\reg.exe add "HKEY_CURRENT_USER\Control Panel\International" /v LocaleName /d en-GB /f
```
`%SystemRoot%\System32\reg.exe` executes regedit (you can also just use reg, but in a batch environment i prefer using the whole path)<br>
`add` adds the following Keyname, value, string etc.<br>
`"HKEY_CURRENT_USER\Control Panel\International"` is the keyname<br>
`/v` is the valuename (here: LocalName)<br>
`/d` specifies the data for the entry (here: en-GB)<br>
`/f` adds the registry entry without prompting for confirmation (you can also remove /f)<br>

As you can see I am using the latter approach in my Bat-File of this repo.

If you want to read out the current regional language settings from the registry, you can just open regedit and search for the value or do it via a Terminal command (I also provided a bat for this command in the repo):
```
@ECHO OFF
cls
ECHO read current regional setting language from registry
%SystemRoot%\System32\reg.exe query "HKEY_CURRENT_USER\Control Panel\International" /v LocaleName /s
pause
```

## Troubeshooting
If your default setting didn't get reverted toy your default because you accidently closed the language changer window or your PC crashed you can always reset it by going into your regional settings in Windows and selecting your region or run
`"%SystemRoot%\System32\reg.exe add "HKEY_CURRENT_USER\Control Panel\International" /v LocaleName /d %LocaleName% /f"` (where %LocaleName% has to be replaced by your locale, e.g. de-DE) in your Terminal/Run-Command/Commandline.
