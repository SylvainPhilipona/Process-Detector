<#
.NOTES
    *****************************************************************************
    ETML
    Name:	Compile-Project.ps1
    Author:	Sylvain Philipona
    Date:	23.02.2023
 	*****************************************************************************
    Modifications
 	Date  : 29.03.2023
 	Author: Sylvain Philipona
 	Reason: 
 	*****************************************************************************
.SYNOPSIS
    Compile tout les fichiers de scripts en 1 seul
 	
.DESCRIPTION
    Récupère tout les scripts .ps1 d'un dossier, les compile en 1 seul et crée un fichier .bat de lancement
    Permet de générer un fichier simple à uttiliser pour l'utilisateur final
  	
.PARAMETER compiled
    

.OUTPUTS
	- 

.EXAMPLE
    .\Compile-Project.ps1
 	
#>

param (
    [string]$compiled = "Impero-Detector.ps1",
    [string]$mainScript = "Impero-Detector.ps1",
    [string]$configsScript = "Configs.ps1",
    [string]$scriptsPath = "./Scripts",
    [string]$outputPath = "./Impero-Detector"
)

# Get all scripts from the path
$scripts = Get-ChildItem -Path $scriptsPath -Filter *.ps1 -Exclude @($mainScript, $configsScript) -Recurse

# Create the Output folder and move to it
New-Item $outputPath -ItemType Directory -Force | Out-Null
Set-Location $outputPath

# Get all files content and wrap it in a 'Function'
# Remove all ".\" and ".ps1". Because in the files the scripts are called like this ".\My-Function.ps1" and when wrapped like this "My-Function"
# The result will be output in a file 
$wrapContent = ""
$wrapContent += "Function $($configsScript.Replace('.ps1', '')) {"
$wrapContent += [IO.File]::ReadAllText("$scriptsPath\$configsScript").Replace(".\", "").Replace(".ps1", "")
$wrapContent += "}"
foreach($script in $scripts){
    $wrapContent += "Function $($script.Name.Replace('.ps1', '')) {"
    $wrapContent +=     [IO.File]::ReadAllText($script.FullName).Replace(".\", "").Replace(".ps1", "")
    $wrapContent += "}"
}
$wrapContent += [IO.File]::ReadAllText("$scriptsPath\$mainScript").Replace(".\", "").Replace(".ps1", "")
$wrapContent >> $compiled

# Create the launch file
New-Item -Path . -Name "start.bat" -Force | Out-Null
Set-Content "start.bat" "powershell -WindowStyle hidden -executionPolicy bypass -file $compiled"
# Set-Content "start.bat" "powershell -executionPolicy bypass -file $compiled"

# Go back in the main folder
Set-Location "../"