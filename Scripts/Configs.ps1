﻿<#
.NOTES
    *****************************************************************************
    Name:	Configs.ps1
    Author:	Sylvain Philipona
    Date:	
 	*****************************************************************************
    Modifications
 	Date  : 
 	Author: 
 	Reason: 
 	*****************************************************************************
.SYNOPSIS
    Project configs
 	
.DESCRIPTION
    This file contains all mandatiry configs for the project to work
    The values are an example
 	
.OUTPUTS
	An PSCustomObject that contains all configs

.EXAMPLE
    .\Configs.ps1

    Data                                      Trigger
    ----                                      -------
    {Name, MinDelta, Unit, IterationDuration} {Browser, Website}
    
#>

return [PSCustomObject]@{
    Data = @{
        Name = "ImperoClient"
        MinDelta = 10
        Unit = "MB"
        IterationDuration = 300
    }

    Trigger = @{
        Browser = "msedge"
        Website = "https://enseignement.section-inf.ch/"
        Timeout = 5000
    }
}