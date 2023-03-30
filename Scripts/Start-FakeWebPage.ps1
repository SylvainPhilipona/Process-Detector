<#
.NOTES
    *****************************************************************************
    Name:	Start-FakeWebPage.ps1
    Author:	Sylvain Philipona
    Date:	29.03.2023
 	*****************************************************************************
    Modifications
 	Date  : 30.03.2023
 	Author: Sylvain Philipona
 	Reason: UTF-8 with BOM encoding
 	*****************************************************************************
.SYNOPSIS
    Open a webpage on eachs monitors
 	
.DESCRIPTION
    Open a webpage on all monitors of the user. 
    The web browser and the website are defined in parameters
  	
.PARAMETER Website
    The website that will be open

.PARAMETER Browser
    The web browser that will be use to open the website
 	
.OUTPUTS
	- Create 1 web browser window on fullscreen and on each monitors

.EXAMPLE
    .\Start-FakeWebPage.ps1 -Website "gesteleves.etmlnet.local" -Browser msedge
 	
.LINK
    https://www.reddit.com/r/PowerShell/comments/6qqagj/get_relative_positioning_of_monitors/
    https://stackoverflow.com/questions/70973523/powershell-launch-window-on-second-screen

#>

# Script parameters
param(
    [Parameter(Position=0)]
    [string]$Website = "www.etml.ch",

    [Parameter(Position=1)]
    [ValidateSet("chrome","msedge")]
    [string]$Browser = "chrome",

    [Parameter(Position=3)]
    [switch]$WhatIf
)

# Load the windows form assembly and obtains all monitors connected to the computer
Add-Type -AssemblyName System.Windows.Forms
$screens = @([System.Windows.Forms.Screen]::AllScreens | Select-Object primary, workingarea)

# Open a web browser on each monitor
[bool]$completed = $true
$screens | ForEach-Object{

    # Obtains X and Y position of the monitor
    $x = $_.workingarea.X
    $y = $_.workingarea.Y
    $i = $screens.IndexOf($_)+1

    # The arguments ensure that the browser is opened in a new window, in full-screen mode, in a separate user data directory for each monitor.
    # At the correct X and Y positions on the screen. 
    # The website to be opened is specified by the $Website variable
    try{
        Start-Process $Browser ("--new-window",  "--start-fullscreen", "--user-data-dir=c:/screen$i","--window-position=$x,$y", $Website) -ErrorAction Stop
    }
    catch{
        $completed = $false
    }
}

return $completed