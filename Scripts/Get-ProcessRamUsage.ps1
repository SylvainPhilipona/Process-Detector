<#
.NOTES
    *****************************************************************************
    Name:	Get-ProcessRamUsage.ps1
    Author:	Sylvain Philipona
    Date:	29.03.2023
 	*****************************************************************************
    Modifications
 	Date  : 
 	Author: 
 	Reason: 
 	*****************************************************************************
.SYNOPSIS
    Get the ram usage of a process
 	
.DESCRIPTION
    Get and return the ram usage of all iterations of the process defined in parameters.
    The value is returned according to unit defined in parameters
  	
.PARAMETER ProcessName
    The name of the process to look for the ram usage

.PARAMETER Unit
    The unit that the value will be returned
 	
.OUTPUTS
	The output are the ram usage of all iterations of the process

.EXAMPLE
    .\Get-ProcessRamUsage.ps1 -ProcessName notepad -Unit KB
 	
    15480
#>

# Script parameters
param(
    [Parameter(Position=0)]
    [string]$ProcessName = "ImperoClient",

    [Parameter(Position=1)]
    [ValidateSet("Byte","KB","MB", "GB")]
    [string]$Unit = "MB"
)

# Table to convert differents units
$convertTable = @{
    "Byte" = [math]::Pow(1024,0)
    "KB" = [math]::Pow(1024,1)
    "MB" = [math]::Pow(1024,2)
    "GB" = [math]::Pow(1024,3)
}

# Get all processes by the name defined in params
$processes = (Get-Process -Name $ProcessName -ErrorAction SilentlyContinue)

# Check if the process defined in params exists
if($processes.Count -eq 0){
    return 0
}

# Return an array of all processes RAM consumption
return ($processes | ForEach-Object -process {$_.WorkingSet64 / $convertTable[$Unit]})