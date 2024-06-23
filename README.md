<p align="center">
   <img src="https://github.com/Limpster/Fallout76LanguageChanger/assets/7376283/62ac5429-a7af-43aa-bd34-63a93290eea8" alt="Language Changer Screenshot"/>
</p>

- [Fallout76LanguageChanger](#fallout76languagechanger)
  - [tl;dr](#tldr)
  - [Information](#information)
  - [Requirements](#requirements)
  - [How do I use this thing?](#how-do-i-use-this-thing)
  - [Configuration](#configuration)
    - [Set the language](#set-the-language)
    - [Set Fallout 76 executable (usually not needed)](#set-fallout-76-executable-usually-not-needed)
    - [Set timeout (for slower machines)](#set-timeout-for-slower-machines)
  - [Manual approach](#manual-approach)
      - [REG-File](#reg-file)
      - [Edit the registry via Terminal/Commandline](#edit-the-registry-via-terminalcommandline)
      - [Edit the registry by hand](#edit-the-registry-by-hand)
      - [Read current regional settings from registry batch](#read-current-regional-settings-from-registry-batch)
  - [Troubeshooting](#troubeshooting)
  - [Experimental](#experimental)
      - [Different Text and Audio Language](#different-text-and-audio-language)
  - [Credits](#credits)

# Fallout76LanguageChanger
A simple way to change your windows region back and forth, allowing Fallout 76 (and maybe some other GamePass-PC titles) to run in a language of choice.
This is just a batch-file to change the language, launch the game and revert the changes after ending your game session.

## tl;dr
Download "[Fallout 76 Language Changer.bat](https://github.com/Limpster/Fallout76LanguageChanger/raw/main/Fallout%2076%20Language%20Changer.bat)" (right-click and save) and run it.
If it doesn't work, come back here and read the instructions.

## Information
Got Fallout 76 for Gamepass and I wanted to play it in english, unfortunately there is no setting to change the localization in the game or via a launcher. After some google-fu I always read the same (mostly not working or impractical) solutions/recommendations (changing the whole regional setting for Windows manually which also changes date/time, currency etc., changing the whole system language, changing Gamepass/Store country in your Microsoft account, even using VPN etc.[[<sup>1</sup>]](https://www.reddit.com/r/fo76/comments/xxnhcr/changing_the_language_settings_microsoft_store/), [[<sup>2</sup>]](https://www.reddit.com/r/fo76/comments/q20su1/how_to_change_game_language_fallout_76_gamepass/), [[<sup>3</sup>]](https://answers.microsoft.com/en-us/xbox/forum/all/fallout-76-change-the-language/f5eb011d-92f3-4428-96a6-e4dc0f2f2422)) which sounded a little over the top or wasn't working at all and I couldn't find a simple and easy solution.  
This language changer will edit the regional language setting in the Windows registry to a chosen value without altering any formatting (date, currency, etc.), system or input language itself and will revert the language string back to default after your game session has ended. **Only the String for "LocaleName" will be changed**, all the currency, date/time and formatting settings will remain the same.  
Since Fallout 76 (and maybe other Gamepass-PC titles, e.g. Forza 4 seem to have the same "problem") run only in the language set in the regional language settings of Windows, I thought about making it a hassle-free and easy process without clicking trough the Windows regional settings and reverting them manually after each session.  
You just run the batch file and that's it :)  
> Steam-Users and BethesdaLauncher users **might** not need this language changer as they can change the language in their respective launchers as far as I know (since I don't own the Steam/Bethesda Launcher Version, I am not able to help users with these launchers but you can get in touch with me and work on it together)

I hope this little script helps you to enjoy the game in another language [(also, I heard that some quest with a poem was translated incorrectly and thus it's not working propery for some other languages than english)](https://www.reddit.com/r/fo76/comments/1bq71w7/psa_for_german_language_players_trying_to_solve/)


## Requirements
You will have the best experience with this language changer if you are using 
* Gamepass Version of Fallout 76  
  (I don't know if this thing will be usefull for Steam or Bethesda Launcher)
* Windows 11  
  (will probably work with other/older/newer versions, but has only been tested on Windows 11 23H2 22635.3495 for the time being, I don't see a reason why it shouldn't work with other versions)
* (Optional, actually completely unnecessary and I guess I will remove this method soon) [UWPHook](https://github.com/BrianLima/UWPHook)  
  You can add the game as a non-steam game without UWPHook, actually I don't see a reason to use UWPHook at all; unfortunately my first attempts of adding the game as non-steam game guided me to UWPHook, further testing showed me that it's actually not needed

  > almost everything this batch does is explained inside the file with comments (REM)

If you don't want to use the language changer and just want to change the region a little easier other than clicking through the windows settings, you will find more information below, explaining other -still easy- solutions for this matter. Feel free to edit the batchfiles to your liking and tell me about improvements in the issues tab so I can add them and make the files better.

## How do I use this thing?
> If you want to play the game localized in english, you just have to download the bat-file and run it. You don't have to edit anything, it should work out of the box! (default is en-GB)
1. Download the batch-file "[Fallout 76 Language Changer.bat](https://github.com/Limpster/Fallout76LanguageChanger/raw/main/Fallout%2076%20Language%20Changer.bat)" (right-click and save) and save the file in a directory where windows can access it without problems
2. open the batch-file with a texteditor of your choice and make the required changes in the configuration inside of the batch-file
   (configuration explained below and to a certain extent inside of the file)
> in most cases you just have to edit the desired language and that's it!
3. save the changes
4. double click the batch-file and that's it, you did it! You found the G.E.C.K. and future generations will survive thanks to your contribution to the wasteland
   
Further options will be explained below.

<details>
   <summary>(Optional 1) How do I use this thing if I added Fallout 76 as non-Steam Game without UWPHook?</summary><br>
Since we can't add a batch-file as non-steam game, you can also just add any exe (e.g. explorer.exe) as non-steam game and edit it (see Step 7) to point to my batch-file later, following the steps below.
   
1. Download the batch-file "[Fallout 76 Language Changer.bat](https://github.com/Limpster/Fallout76LanguageChanger/raw/main/Fallout%2076%20Language%20Changer.bat)" (right-click and save) and save the file in a directory where windows can access it without problems
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
Adding a Gamepassgame as a non-steam game is also possible with UWPHook, additionaly it adds an icon, logo and a header to your library (so you dont have to do it by hand).  

   Method 1:  
   I assume that you already added the game to Steam via UWPHook.exe, so you have it appear in your Library with a nice Icon and Header. If not: head over to [UWPHook](https://github.com/BrianLima/UWPHook) and follow the instructions.  
   
   Method 2:   
   (If you don't want to add the game with UWPHook) Since we can't add a batch-file as non-steam game, you can also just add any exe (e.g. explorer.exe) as non-steam game and edit it (see Step 7) to point at my batch-file later, following the steps below.  
   
1. Download the batch-file "[Fallout 76 Language Changer UWPHook.bat](https://github.com/Limpster/Fallout76LanguageChanger/raw/main/Fallout%2076%20Language%20Changer%20UWPHook.bat)" (right-click and save) and save the file in a directory where windows can access it without problems
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
Obviously only languages downloaded and available for your game will work, I tested it with en-GB, pt-BR, es-ES, pl-PL and de-DE entering the main menu.  
Example for english language: `set "LocaleNew=en-GB"`  
<details>
   <summary>(possible) available languages</summary><br>
   
Your mileage may vary, but these are the languages I found in the "locales" folder of my Fallout 76 game folder:  
``` de,en-GB,en-US,es,es-419,fr,it,ja,pl,pt-BR,pt-PT,ru,zh-CN,zhTW ```

 Languages according to Steam:
|                         | Interface | Full Audio | Subtitles |
| ----------------------- | --------- | ---------- | --------- |
| English                 | ✔         | ✔         | ✔         |
| French                  | ✔         | ✔         | ✔         |
| Italian                 | ✔         | ✔         | ✔         |
| German                  | ✔         | ✔         | ✔         |
| Spanish - Spain         | ✔         | ✔         | ✔         |
| Japanese                | ✔         | ✔         | ✔         |
| Korean                  | ✔         |            | ✔         |
| Polish                  | ✔         |            | ✔         |
| Traditional Chinese     | ✔         |            | ✔         |
| Russian                 | ✔         |            | ✔         |
| Simplified Chinese      | ✔         |            | ✔         |
| Spanish - Latin America | ✔         |            | ✔         |
| Portuguese - Brazil     | ✔         |            | ✔         |

</details>

### <ins>Set Fallout 76 executable (usually not needed)</ins>
The same goes for the Fallout 76 executable, in the unlikely case the name of the executable will change, you can edit it here.
This is relevant since we are checking if the exectuable is running before we revert the language settings back to default.  
Example: `set "Fallout_executable=Project76_GamePass.exe"`
<details>
<summary>Further info regarding the executable</summary>
Maybe relevant if someone wants to edit the batch for Steam where Fallout 76 might have another *.exe, so the script can keep "listening" if Fallout is running.
</details>
<details>
<summary>only for Fallout 76 Language Changer UWPHook.bat</summary><br>
If you are launching the Game with UWPHook through Steam and not trough the regular shortcut or the XBOX/Gamepass App, we have to tell the file, where to find UWPHook.exe to launch Fallout 76.
Edit this setting to set the path to UWPHook.exe  
   
   example: `set "path_to_UWPHook.exe=C:/PATH/TO/UWPHook.exe"`

I guess that the AUMID/APPID will remain the same, unless they release some kind of new version for the game, anyhow, here you are able to edit the AUMID/APPID in the unlikely case of a change. UWPHook.exe shows the ID, you can also easily copy it after adding a shortcut to Steam with UWPHook.
set the UWPHook.exe AUMID/AppID for Fallout 76 (in case the ID will change, you can edit it here)<br>
`set "AUMID=BethesdaSoftworks.Fallout76-PC_3275kfvn8vcwc!Fallout76"`
</details>

### <ins>Set timeout (for slower machines)</ins>
Here we can set the timeout in seconds to check if the executables (gamingservicesui.exe and the Fallout executable) are still running, sometimes the timeout is too low (e.g. Fallout doesn't start in time/fast enough and the script will terminate itself before the game even launched) thus we can set a higher timeout here. The higher the timeout, the longer it takes until the script will close/reset to the default language after ending your game (you will see the script slighty longer before it closes itself). Slower machines should increase the timeout by a few seconds.  
Default timeout is 5 seconds.  
Example: `set "timeout=5"`  
(might be smarter to check for the running applications at a later point instead of relying on a timeout in this situation, I might edit the script when I find time and try to improve the method)

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
`%SystemRoot%\System32\reg.exe` executes regedit (you can also just use reg, but in a batch environment I prefer using the whole path)  
`add` adds the following Keyname, value, string etc.  
`"HKEY_CURRENT_USER\Control Panel\International"` is the keyname  
`/v` is the valuename (here: LocalName)  
`/d` specifies the data for the entry (here: en-GB)  
`/f` adds the registry entry without prompting for confirmation (you can also remove /f)  
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
If your default settings didn't get reverted to your default language because you accidently closed the language changer window or your PC crashed you can always reset it by  
a) changing your regional settings in the corresponding menu in Windows  
b) run `"%SystemRoot%\System32\reg.exe add "HKEY_CURRENT_USER\Control Panel\International" /v LocaleName /d %LocaleName% /f"` (where %LocaleName% has to be replaced by your locale, e.g. de-DE) in your Terminal/Run-Command/Commandline  
c) edit registry by hand (see above)

## Experimental
> [!CAUTION]
> Experimental, your mileage my vary, make backups!
#### <ins>Different Text and Audio Language</ins>
(thanks @https://github.com/hersiker for opening the first [issue]([url](https://github.com/Limpster/Fallout76LanguageChanger/issues/1)) asking this specific question)  
As of now it's not in the scope of this script, because (from my understanding) it's only possible to achieve by modifying the files e.g. renaming the audio files to the corresponding language (maybe it is possible with linking/pointing to the right files and "making the game think it's using the right files" without actually moving/renaming the audio files.  
There might be a way to temporary "rename" the files with a script so we don't have to copy files/actually rename them. I will see if I can find a way to create a script for this option (it's not on my priority list, but I keep it in mind).  
> Please note that there are 6 supported audio languages, please check the "[Set the language](#set-the-language)" section for the available languages
<details>
   <summary>
      Instructions<br>
   </summary><br>
Let's say you want to have english audio but german text, here is a possible solution, a quick test ran fine and I had english audio with german text (please take it with a grain of salt since I didn't look too much into this option, the changes are experimental and I don't know if the follwing files are everything you need to change or if the game will crash in certain situations because one file is missing; don't forget to back up your files if you don't want to download/verify the files again in case something goes wrong or you want to revert the changes).

Example for german text with english audio, if you want to have es/fr/it/ja text, follow the steps with the corresponding language code:
> Bonus: for this change you usually don't need my script, we are just renaming the english audio files to the system language, the game will think it loads german audio, but we replaced the german audio with the english audio files.

1. Navigate to your game folder and open the "Data" Folder (e.g. C:\XboxGames\Fallout 76\Content\Data)
2. inside this folder you will see plenty of files, we are especially interested in the "*voices_de.ba2" files ("de"=german, "es"=spanish, "fr"=french, "it"=italian, "ja"=japanese, these are all the supported audio languages)
3. make a backup of all the "*voices_de.ba2" files (=german audio), e.g. rename them to "_*voices_de.ba2"
4. make a copy of all the "*voices.ba2" files (=english audio) (you now have two sets of english audio files)
5. rename all the copies of the english audio files and give them the name of the german audio files e.g. "SeventySix - 00UpdateVoices.ba2" will become "SeventySix - 00UpdateVoices_de.ba2" (you now have 3 sets of audio files: the german audio files backup, the english original files and the english audio files which you renamed to the german audio files)
At the time of writing this instruction you might have to backup/rename 15 files:

| Original Files                  | Renamed to                           |
|---------------------------------|--------------------------------------|
| SeventySix - 00UpdateVoices.ba2 | SeventySix - 00UpdateVoices_de.ba2   |
| SeventySix - 01UpdateVoices.ba2 | SeventySix -   01UpdateVoices_de.ba2 |
| SeventySix - 02UpdateVoices.ba2 | SeventySix -   02UpdateVoices_de.ba2 |
| SeventySix - 03UpdateVoices.ba2 | SeventySix -   03UpdateVoices_de.ba2 |
| SeventySix - 04UpdateVoices.ba2 | SeventySix -   04UpdateVoices_de.ba2 |
| SeventySix - 05UpdateVoices.ba2 | SeventySix -   05UpdateVoices_de.ba2 |
| SeventySix - 06UpdateVoices.ba2 | SeventySix -   06UpdateVoices_de.ba2 |
| SeventySix - 07UpdateVoices.ba2 | SeventySix -   07UpdateVoices_de.ba2 |
| SeventySix - 08UpdateVoices.ba2 | SeventySix -   08UpdateVoices_de.ba2 |
| SeventySix - 09UpdateVoices.ba2 | SeventySix -   09UpdateVoices_de.ba2 |
| SeventySix - 10UpdateVoices.ba2 | SeventySix -   10UpdateVoices_de.ba2 |
| SeventySix - 11UpdateVoices.ba2 | SeventySix -   11UpdateVoices_de.ba2 |
| SeventySix - 12UpdateVoices.ba2 | SeventySix -   12UpdateVoices_de.ba2 |
| SeventySix - 13UpdateVoices.ba2 | SeventySix -   13UpdateVoices_de.ba2 |
| SeventySix - Voices.ba2         | SeventySix -   Voices_de.ba2         |

And that's it, if you run the game now (without my script! just run it from the launcher/shortcut on your desktop etc.) the game should show the text in your system language (e.g like it would run without any modification) but you should be able to hear english audio.
This change is permanent, until they add more audio files or the files become replaced from the launcher due to an update or file verification.

<ins>Other Audio/Text combination</ins>  
You can also have german audio with english text or other combinations, just rename the corresponding files to the language you want to hear and run the LanguageChanger script to change the text (keep in mind that you have to rename the files to the language you chose with the language changer, e.g. if you use my language changer to change the language to japanese, you also have to rename the audio files to the japanese audio files, you get the idea).
</details>

## Credits
Thanks to all the brave redditors for your upvotes, microsoft answers forum users <sub>(why does this forum even exist lol)</sub></sub>, steamcommunity users and stackoverflow professionals who helped me during my little journey of getting all the necessary information and inspiration for the scripts.
I shamelessly borrowed the idea for the colored lines in my batch [here](https://stackoverflow.com/a/21666354), thank you [VisualMagic](https://stackoverflow.com/users/2946716/visual-magic)
