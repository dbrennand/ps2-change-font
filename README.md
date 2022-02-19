# ps2-change-font

A PowerShell script to change Planetside 2's font.

## Introduction

The `PS2-Change-Font.ps1` script will change the in-game font for PlanetSide 2 to any font listed on [Google Fonts](https://fonts.google.com/).

## Prerequisites

* A Google Fonts [API Key](https://developers.google.com/fonts/docs/developer_api#APIKey).

    * Press **Get a Key** and follow the instructions.

## Installation and Usage

From a Administrator PowerShell terminal, run the following commands:

1. Clone the repository:

    ```powershell
    git clone https://github.com/dbrennand/ps2-change-font.git; cd ps2-change-font
    ```

2. Save the absolute path of the script to a variable:

    ```powershell
    $PS2ChangeFontPath = "$($(pwd).Path)\PS2-Change-Font.ps1"
    ```

3. Create a PowerShell script file on your desktop and set the contents to invoke `PS2-Change-Font.ps1`:

    > [!NOTE]
    >
    > If you have PlanetSide 2 installed somewhere other than `C:\`, add the following to the end of the command above to specify the absolute path to your PlanetSide 2 installation.
    >
    > Example for `D:\`: `... -PS2InstallPath "D:\SteamLibrary\steamapps\common\PlanetSide 2"`

    ```powershell
    New-Item -Path "$($HOME)\Desktop\PS2-Change-Font.ps1"
    Set-Content -Path "$($HOME)\Desktop\PS2-Change-Font.ps1" -Value "& $PS2ChangeFontPath -APIKey '<Google Fonts API Key>' -FontFamily '<Font Family>'"
    ```

4. Right click the script on your desktop and click **Run with PowerShell**.

### List Available Font Variants

To list available font variants for a font family, run the script with the `-ListFontVariants` switch:

```powershell
.\PS2-Change-Font.ps1 -APIKey "<Google Fonts API Key>" -FontFamily "<Font Family>" -ListFontVariants
```

Below shows example font variants for the Roboto font family:

```
Available font variants for font family Roboto: 100 100italic 300 300italic regular italic 500 500italic 700 700italic 900 900italic
```

By default the script will use the font variant **regular**. To specify a different font variant, provide the `-FontVariant` parameter similarly to:

```powershell
# Example 1
... -FontVariant "100"
# Example 2
... -FontVariant "100italic"
```
