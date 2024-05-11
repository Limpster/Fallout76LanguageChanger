<p align="center">
   <img src="https://github.com/Limpster/Fallout76LanguageChanger/assets/7376283/62ac5429-a7af-43aa-bd34-63a93290eea8" alt="Language Changer Screenshot"/>
</p>

# Fallout76LanguageChanger
A simple and semi-automatic way to change your windows region back and forth, allowing Fallout 76 (and maybe some other GamePass-PC titles) to run in a chosen language.
This is just a batch-file to change the language, launch the game and revert the changes after ending your game session.

## Information
Got Fallout 76 for Gamepass and I wanted to play it in english, unfortunately there is no setting to change the localization in the game or via a launcher. After some google-fu I always read the same (mostly not working or impractical) solutions/recommendations (changing the whole regional setting for Windows manually which also changes date/time, currency etc., changing the whole system language, changing Gamepass/Store country in your Microsoft account, even using VPN etc.[[<sup>1</sup>]](https://www.reddit.com/r/fo76/comments/xxnhcr/changing_the_language_settings_microsoft_store/), [[<sup>2</sup>]](https://www.reddit.com/r/fo76/comments/q20su1/how_to_change_game_language_fallout_76_gamepass/), [[<sup>3</sup>]](https://answers.microsoft.com/en-us/xbox/forum/all/fallout-76-change-the-language/f5eb011d-92f3-4428-96a6-e4dc0f2f2422)) which sounded a little over the top or wasn't working at all and I couldn't find a simple and easy solution.<br>
This language changer will edit the regional language setting in the Windows registry to a chosen value without altering any formatting (date, currency, etc.), system or input language itself and will revert the language string back to default after your game session has ended. **Only the String for "LocaleName" will be changed**, all the currency, date/time and formatting settings will remain the same.<br>
Since Fallout 76 (and maybe other Gamepass-PC titles, e.g. Forza 4 seem to have the same "problem") run only in the language set in the regional language settings of Windows, I thought about making it a hassle-free and easy process without clicking trough the Windows regional settings and reverting them manually after each session.<br>
You just run the batch file and that's it :)<br>
> Steam-Users and BethesdaLauncher users **might** not need this language changer as they can change the language in their respective launchers as far as I know (since I don't own the Steam/Bethesda Launcher Version, I am not able to help users with these launchers but you can get in touch with me and work on it together)

I hope this little script helps you to enjoy the game in another language [(also, I heard that some quest with a poem was translated incorrectly and thus it's not working propery for some other languages than english)](https://www.reddit.com/r/fo76/comments/1bq71w7/psa_for_german_language_players_trying_to_solve/)


## Requirements
You will have the best experience with this language changer if you are using 
* Gamepass Version of Fallout 76<br>
  (I don't know if this thing will be usefull for Steam or Bethesda Launcher)
* Windows 11<br>
  (will probably work with other/older/newer versions, but has only been tested on Windows 11 23H2 22635.3495 for the time being, I don't see a reason why it shouldn't work with other versions)
* (Optional, actually completely unnecessary and I guess I will remove this method soon) [UWPHook](https://github.com/BrianLima/UWPHook)<br>
  You can add the game as a non-steam game without UWPHook, actually I don't see a reason to use UWPHook at all; unfortunately my first attempts of adding the game as non-steam game guided me to UWPHook, further testing showed me that it's actually not needed

  > almost everything this batch does is explained inside the file with comments (REM)

If you don't want to use the language changer and just want to change the region a little easier other than clicking through the windows settings, you will find more information below, explaining other -still easy- solutions for this matter. Feel free to edit the batchfiles to your liking and tell me about improvements in the issues tab so I can add them and make the files better.

## How do I use this thing?
1. Download the batch-file "[Fallout 76 Language Changer.bat](https://github.com/Limpster/Fallout76LanguageChanger/blob/main/Fallout%2076%20Language%20Changer.bat)" and save the file in a directory where windows can access it without problems
2. open the batch-file with a texteditor of your choice and make the required changes in the configuration inside of the batch-file<br>(configuration explained below and to a certain extent inside of the file)
> in most cases you just have to edit the desired language, the rest should work out of the box
3. save the changes
4. double click the batch-file and that's it, you did it! You found the G.E.C.K. and future generations will survive thanks to your contribution to the wasteland
   
Further options will be explained below.

<details>
<summary>(Optional 1) How do I use this thing if I added Fallout 76 as non-Steam Game without UWPHook?</summary><br>
Since we can't add a batch-file as no-steam game, you can also just add any exe (e.g. explorer.exe) as non-steam game and edit it (see Step 7) to point to my batch-file later, following the steps below.
   
1. Download the batch-file "[Fallout 76 Language Changer.bat](https://github.com/Limpster/Fallout76LanguageChanger/blob/main/Fallout%2076%20Language%20Changer.bat)" and save the file in a directory where windows can access it without problems
2. open the batch-file with a texteditor of your choice and make the required changes in the configuration inside of the batch-file (configuration explained below and to a certain extent inside of the file)
> in most cases you just have to edit the desired language, the rest should work out of the box
3. save your changes in the batch-file
4. open your Steam library
5. right click on your Fallout 76 non-Steam Shortcut (or the exe you added as dummy)
6. chose "Properties"
7. look for the line "Target", click on "Browse" and search for the batch-file
8. chose the batch-file
9. you can leave "start in" empty (seems to work fine with or without content)
10. remove the launch options (might not be necessary, seems to work fine with or without)
11. close the properties window in Steam
12. you can now run the game from the Steam library or run it from a shortcut (Steam library -> right click the game -> manage -> add desktop shortcut)
13. you did it, you found the G.E.C.K. and future generations will survive thanks to your contribution to the wasteland
</details>
<details>
<summary>(Optional 2) How do I use this thing if I added Fallout 76 as non-Steam Game with UWPHook?</summary><br>
Adding a Gamepassgame as a non-steam game is also possible with UWPHook, additionaly it adds an Icon, Logo and a Header to your library (so you dont have to do it by hand).<br>
Method 1:<br>
I assume that you already added the game to Steam via UWPHook.exe, so you have it appear in your Library with a nice Icon and Header. If not: head over to [UWPHook](https://github.com/BrianLima/UWPHook) and follow the instructions.<br>
Method 2:<br>
(If you don't want to add the game with UWPHook) Since we can't add a batch-file as no-steam game, you can also just add any exe (e.g. explorer.exe) as non-steam game and edit it (see Step 7) to point at my batch-file later, following the steps below.<br><br>

1. Download the batch-file "[Fallout 76 Language Changer UWPHook.bat](https://github.com/Limpster/Fallout76LanguageChanger/blob/main/Fallout%2076%20Language%20Changer%20UWPHook.bat)" and save the file in a directory where windows can access it without problems
2. open the batch-file with a texteditor of your choice and make the required changes in the configuration inside of the batch-file (configuration explained below and to a certain extent inside of the file)
3. save your changes in the batch-file
4. open your Steam library
5. right click on your Fallout 76 non-Steam Shortcut (or the exe you added as dummy)
6. chose "Properties"
7. look for the line "Target", click on "Browse" and search for the batch-file
8. chose the batch-file
9. you can leave "start in" empty (seems to work fine with or without content)
10. remove the launch options (might not be necessary, seems to work fine with or without)
11. close the properties window in Steam
12. you can now run the game from the Steam library or run it from a shortcut (Steam library -> right click the game -> manage -> add desktop shortcut)
13. you did it, you found the G.E.C.K. and future generations will survive thanks to your contribution to the wasteland
</details>

## Configuration
You will find a few settings inside the batch-file which you have to edit, they are all explained (some with examples) in the file and in this readme
> in most cases you just have to edit the desired language, the rest should work out of the box

### <ins>Set the language</ins>
Set the desired language you want to play Fallout 76 in, e.g. en-GB, pt-BR, es-ES, pl-PL, de-DE etc.
Obviously only languages downloaded and available for your game will work, I tested it with en-GB, pt-BR, es-ES, pl-PL and de-DE entering the main menu.<br>
Example for english language: `set "LocaleNew=en-GB"`
### <ins>Set Fallout 76 executable (usually not needed)</ins>
The same goes for the Fallout 76 executable, in the unlikely case the name of the executable will change, you can edit it here.
This is relevant since we are checking if the exectuable is running before we revert the language settings back to default.<br>
Example: `set "Fallout_executable=Project76_GamePass.exe"`
<details>
<summary>Further info regarding the executable</summary>
Maybe relevant if someone wants to edit the batch for Steam where Fallout 76 might have another *.exe, so the script can keep "listening" if Fallout is running.
</details>
<details>
<summary>only for Fallout 76 Language Changer UWPHook.bat</summary><br>
If you are launching the Game with UWPHook through Steam and not trough the regular shortcut or the XBOX/Gamepass App, we have to tell the file, where to find UWPHook.exe to launch Fallout 76.
Edit this setting to set the path to UWPHook.exe<br>

example: `set "path_to_UWPHook.exe=C:/PATH/TO/UWPHook.exe"`

I guess that the AUMID/APPID will remain the same, unless they release some kind of new version for the game, anyhow, here you are able to edit the AUMID/APPID in the unlikely case of a change. UWPHook.exe shows the ID, you can also easily copy it after adding a shortcut to Steam with UWPHook.
set the UWPHook.exe AUMID/AppID for Fallout 76 (in case the ID will change, you can edit it here)<br>
`set "AUMID=BethesdaSoftworks.Fallout76-PC_3275kfvn8vcwc!Fallout76"`
</details>

## Manual approach
If you don't want to run the batch because it doesn't fit your needs, your have plenty of methods to change the language settings without clicking through the windows settings, I will give you some ideas:
#### <ins>REG-File</ins>
  You can create a REG-File which enters the chosen value directly in the registry. Create an empty textfile with an editor of your choice, insert the following code (here: en-GB for english), save it as *.reg file (e.g. english.reg) and doubleclick to make changes to the registry (I added [examples](https://github.com/Limpster/Fallout76LanguageChanger/tree/main/Files) to this repo so you can download them straight away)
```
  Windows Registry Editor Version 5.00

[HKEY_CURRENT_USER\Control Panel\International]
"LocaleName"="en-GB"
```
#### <ins>Edit the registry via Terminal/Commandline</ins>
  open your Terminal/Commandline and type in the follwing code (here: en-GB for english) and press Enter, the changes will be made to the registry right away!

```
%SystemRoot%\System32\reg.exe add "HKEY_CURRENT_USER\Control Panel\International" /v LocaleName /d en-GB /f
```
`%SystemRoot%\System32\reg.exe` executes regedit (you can also just use reg, but in a batch environment I prefer using the whole path)<br>
`add` adds the following Keyname, value, string etc.<br>
`"HKEY_CURRENT_USER\Control Panel\International"` is the keyname<br>
`/v` is the valuename (here: LocalName)<br>
`/d` specifies the data for the entry (here: en-GB)<br>
`/f` adds the registry entry without prompting for confirmation (you can also remove /f)<br>
As you can see I am using the latter approach in my batch-file of this repo.

#### <ins>Edit the registry by hand</ins>
open regedit.exe and navigate to `"HKEY_CURRENT_USER\Control Panel\International"`, look for the string "LocalName" and change the data to en-GB or any other language code. Revert the changes by entering your default language

#### <ins>Read current regional settings from registry batch</ins>
If you want to read out the current regional language settings from the registry, you can just open regedit and search for the value or do it via a Terminal command ([I also provided a bat for this command in the repo](https://github.com/Limpster/Fallout76LanguageChanger/tree/main/Files)):
```
@ECHO OFF
cls
ECHO read current regional setting language from registry
%SystemRoot%\System32\reg.exe query "HKEY_CURRENT_USER\Control Panel\International" /v LocaleName /s
pause
```

## Troubeshooting
If your default settings didn't get reverted to your default language because you accidently closed the language changer window or your PC crashed you can always reset it by<br>
a) changing your regional settings in the corresponding menu in Windows<br>
b) run `"%SystemRoot%\System32\reg.exe add "HKEY_CURRENT_USER\Control Panel\International" /v LocaleName /d %LocaleName% /f"` (where %LocaleName% has to be replaced by your locale, e.g. de-DE) in your Terminal/Run-Command/Commandline<br>
c) edit registry by hand (see above)

## Credits
Thanks to all the brave redditors for your upvotes, microsoft answers forum users <sub>(why does this forum even exist lol)</sub></sub>, steamcommunity users and stackoverflow professionals who helped me during my little journey of getting all the necessary information and inspiration for the scripts.
I shamelessly borrowed the idea for the colored lines in my batch [here](https://stackoverflow.com/a/21666354), thank you [VisualMagic](https://stackoverflow.com/users/2946716/visual-magic)
