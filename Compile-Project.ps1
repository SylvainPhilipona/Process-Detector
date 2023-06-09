<#
.NOTES
    *****************************************************************************
    Name:	Compile-Project.ps1
    Author:	Sylvain Philipona
    Date:	23.02.2023
 	*****************************************************************************
    Modifications
 	Date  : 31.03.2023
 	Author: Sylvain Philipona
 	Reason: Code optimisation + Removing comments from compiled script
 	*****************************************************************************
.SYNOPSIS
    Compiles all script files into 1
 	
.DESCRIPTION
    Retrieves all .ps1 scripts from a folder, compiles them into a single file and creates a .bat file for launching
    Allows to generate a simple file to use for the end user
  	
.PARAMETER Compiled
    The name of the compiled file

.PARAMETER MainScript
    The path of the script that launch the project

.PARAMETER ConfigsScripts
    The paths of all configs scripts (Constants + Icons)

.PARAMETER scriptsPath
    The scripts folder

.PARAMETER outputPath
    The folder that will be created and containing the compiled file

.OUTPUTS
	- A folder containing 1 compiled file and a .bat file allowing the user to launch the program

.EXAMPLE
    .\Compile-Project.ps1
 	
#>

# Script parameters
param (
    [string]$Compiled = "Process-Detector.ps1",
    [string]$MainScript = "Process-Detector.ps1",
    [string[]]$ConfigsScripts = @("Configs.ps1", "Icons.ps1"),
    [string]$scriptsPath = "./Scripts",
    [string]$outputPath = "./Process-Detector"
)

# Remove all code comments
function Remove-Comments{
    param(
        [string]$ContentWithComments
    )

    # you can use the replace() method but if you need to match and replace anything more advanced, always use the replace operator
    $ContentWithComments = $ContentWithComments -replace "(?<=\<#)((.|\n)*)(?=\#>)", ""
    $ContentWithComments = $ContentWithComments.Replace("<##>", "")
    $ContentWithComments = $ContentWithComments -replace "#.*", " "
    $ContentWithComments = $ContentWithComments.Replace("`n", "")

    return $ContentWithComments
}

# Remove all ".\" and ".ps1". Because in the files the scripts are called like this ".\My-Function.ps1" and when wrapped like this "My-Function"
function Format-Script {
    param (
        [string]$ScriptFullPath,
        [string]$ScriptName
    )

    $content = ""
    $content += "Function $($ScriptName.Replace('.ps1', '')) {"
    $content += [IO.File]::ReadAllText($ScriptFullPath)
    $content += "}"

    $content = $content.Replace(".\", "")
    $content = $content.Replace(".ps1", "")
    $content = Remove-Comments -ContentWithComments $content

    return $content
}

# Get all scripts from the path
# Except the configs and main scripts
$scripts = Get-ChildItem -Path $scriptsPath -Filter *.ps1 -Exclude @($MainScript, $ConfigsScripts).Split() -Recurse

# Create the Output folder and move to it
Remove-Item $outputPath -Force -Recurse -ErrorAction SilentlyContinue
New-Item $outputPath -ItemType Directory -Force | Out-Null
Set-Location $outputPath

# Get all files content and wrap it in a 'Function'
# Remove all ".\" and ".ps1". Because in the files the scripts are called like this ".\My-Function.ps1" and when wrapped like this "My-Function"
# The result will be output in a file 
$wrapContent = ""

# Format all configs files
foreach($conf in $ConfigsScripts){
    $wrapContent += Format-Script -ScriptFullPath "$scriptsPath\$conf" -ScriptName $conf 
}

# Format all scripts files
foreach($script in $scripts){
    $wrapContent += Format-Script -ScriptFullPath "$script" -ScriptName $script.Name
}

# Format the main file
$wrapContent += [IO.File]::ReadAllText("$scriptsPath\$MainScript").Replace(".\", "").Replace(".ps1", "")

# Compile the content
$wrapContent >> $Compiled

# Create the launch file
New-Item -Path . -Name "start.bat" -Force | Out-Null
Set-Content "start.bat" "powershell -WindowStyle hidden -executionPolicy bypass -file $Compiled"

# Go back in the main folder
Set-Location "../"