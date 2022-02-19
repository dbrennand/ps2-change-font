<#
MIT License

Copyright (c) 2022 dbrennand

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

.SYNOPSIS
    A PowerShell script to change Planetside 2's font.

.DESCRIPTION
    A PowerShell script to change Planetside 2's font by downloading a font from Google Fonts.

.PARAMETER APIKey
    A Google Fonts developer API Key. See: https://developers.google.com/fonts/docs/developer_api

.PARAMETER FontFamily
    The font family to download and use in-game.

.PARAMETER FontVariant
    The font variant of the font family to use. Defaults to: "regular".

.PARAMETER ListFontVariants
    A switch to list available font variants for a font family.

.PARAMETER PS2InstallPath
    Override the script's default Planetside 2 installation path of "C:\Program Files (x86)\Steam\steamapps\common\PlanetSide 2".
    If your game is somewhere else. For example on D drive. You would provide something like:
        "D:\SteamLibrary\steamapps\common\PlanetSide 2"

.EXAMPLE
    .\PS2-Change-Font.ps1 -APIKey "API Key here." -FontFamily "Roboto"

.EXAMPLE
    .\PS2-Change-Font.ps1 -APIKey "API Key here." -FontFamily "Roboto" -PS2InstallPath "D:\SteamLibrary\steamapps\common\PlanetSide 2"

.EXAMPLE
    .\PS2-Change-Font.ps1 -APIKey "API Key here." -FontFamily "Roboto" -ListFontVariants
#>
[CmdletBinding()]
param (
    [Parameter(Mandatory = $true)]
    [String]
    $APIKey,

    [Parameter(Mandatory = $true)]
    [String]
    $FontFamily,

    [Parameter(Mandatory = $false)]
    [String]
    $FontVariant = "regular",

    [Parameter(Mandatory = $false)]
    [Switch]
    $ListFontVariants,

    [Parameter(Mandatory = $false)]
    [String]
    $PS2InstallPath
)

# Declare constant variables
$Version = "0.0.2"
$GoogleFontsEndpoint = "https://www.googleapis.com/webfonts/v1/webfonts"

# Start Planetside 2
if (-not $ListFontVariants) {
    Write-Output -InputObject "Starting Planetside 2..."
    Start-Process steam://rungameid/218230
    Read-Host -Prompt "Wait for the green Planetside 2 PLAY button to light up green. Press the ENTER key to continue."
}

# Get a list of fonts from the Google Fonts API
try {
    $Fonts = Invoke-RestMethod -Uri $GoogleFontsEndpoint -Method GET -Body @{"key" = $APIKey; "sort" = "alpha" }
}
catch {
    throw "Failed to get a list of fonts from Google Fonts: $($_.Exception.Message)"
}

# Find the font specified
$SelectedFont = $Fonts.Items | Where-Object -FilterScript { $_.Family -like $FontFamily }
if (-not $SelectedFont) {
    throw "Failed to find font family $($FontFamily)."
}

# If ListFontVariants switch has been provided, output the available font variants
if ($ListFontVariants) {
    Write-Output -InputObject "Available font variants for font family $($FontFamily): $($SelectedFont.Variants)"
    exit
}

# Download the specified font and overwrite Planetside 2's existing font Geo-Md.ttf
## Check font variant for specified font family is available. If not, fallback to regular
if (-not $SelectedFont.Files.$FontVariant) {
    Write-Warning -Message "Selected font variant $($FontVariant) is not available. Falling back to regular."
    $FontVariant = "regular"
}
try {
    Write-Output -InputObject "Downloading font $($FontFamily) and overwriting default Planetside 2 font Geo-Md.ttf."
    if ($PS2InstallPath) {
        Invoke-WebRequest -Uri $SelectedFont.Files.$FontVariant -OutFile "$($PS2InstallPath)\UI\Resource\Fonts\Geo-Md.ttf"
    }
    else {
        Invoke-WebRequest -Uri $SelectedFont.Files.$FontVariant -OutFile "$(${Env:ProgramFiles(x86)})\Steam\steamapps\common\PlanetSide 2\UI\Resource\Fonts\Geo-Md.ttf"
    }
}
catch {
    throw "Failed to download font $($FontFamily) from URL $($SelectedFont.Files.$FontVariant) and overwrite Geo-Md.ttf: $($_.Exception.Message)"
}

Write-Output -InputObject "Finished. Happy cert farming :)"
Start-Sleep -Seconds 3
