# ps2-change-font

A PowerShell script to change Planetside 2's font.

## Introduction

This script allows a user to change the in-game font for Planetside 2 to any font listed on [Google Fonts](https://fonts.google.com/).

## Prerequisites

* A Google Fonts [API Key](https://developers.google.com/fonts/docs/developer_api#APIKey).

    - Press **Get a Key** and follow the instructions.

## Installation and Usage

From a Administrator PowerShell terminal, run the following commands:

1. Clone the repository: `git clone https://github.com/dbrennand/ps2-change-font.git; cd ps2-change-font`

2. Save the path to the script to a variable: `$PS2ChangeFontPath = "$($(pwd).Path)\PS2-Change-Font.ps1"`

3. Create a PowerShell script file on your desktop and set the contents to invoke the PS2-Change-Font script: `New-Item -Path "$HOME\Desktop\PS2-Change-Font.ps1"; Set-Content -Path "$HOME\Desktop\PS2-Change-Font.ps1" -Value "& $PS2ChangeFontPath -APIKey 'Insert your API Key here.' -FontFamily 'Insert chosen font family here.'"`

> [!NOTE]
> If you have Planetside 2 installed somewhere other than C:\, add the following to the end of the command above to specify the path to your Planetside 2 installation.
>
> Example for D:\: `-PS2InstallPath "D:\SteamLibrary\steamapps\common\PlanetSide 2"`

4. Right click the script on your desktop and select *Run with PowerShell*.

### Font Variant

To list available font variants for a font family, run the script with the `-ListFontVariants` switch: `.\PS2-Change-Font.ps1 -APIKey "Insert your API Key here." -FontFamily "Insert chosen font family here." -ListFontVariants`

Below shows example font variants for the Roboto font family:

```
Available font variants for font family Roboto: 100 100italic 300 300italic regular italic 500 500italic 700 700italic 900 900italic
```

By default the script will use the font variant **regular**. To specify a different font variant, provide the `-FontVariant` parameter. E.g. `... -FontVariant "300"` or `... -FontVariant "100"`
