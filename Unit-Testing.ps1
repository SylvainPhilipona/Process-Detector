<#
.NOTES
    *****************************************************************************
    Name:	Unit-Testing.ps1
    Author:	Sylvain Philipona
    Date:	30.03.2023
 	*****************************************************************************
    Modifications
 	Date  : 
 	Author: 
 	Reason: 
 	*****************************************************************************
.SYNOPSIS
    UnIts tests
 	
.DESCRIPTION
    
 	
.OUTPUTS
	The result of unIts tests

.EXAMPLE
    .\UnIt-Testing.ps1

    
#>

# https://pester.dev/docs/quick-start
# https://pester.dev/docs/v4/usage/assertions
# 
# Install-Module -Name Pester -Scope CurrentUser -RequiredVersion 5.3.1 -Force 

Describe "Configs"{
    It "Process name = ImperoClient"{
        (.\Scripts\Configs.ps1).Data.Name | Should Be "ImperoClient"
    }
}

Describe "Get-ProcessRamUsage"{
    It "Notepad is closed = 0"{
        .\Scripts\Get-ProcessRamUsage.ps1 -ProcessName notepad -UnIt Byte | Should Be 0
    }

    It "Explorer is > than 0 MB"{
        .\Scripts\Get-ProcessRamUsage.ps1 -ProcessName explorer -UnIt MB | Should BeGreaterThan 0 
    }

    It "Explorer in MB > Explorer in GB"{
        .\Scripts\Get-ProcessRamUsage.ps1 -ProcessName explorer -UnIt MB | Should BeGreaterThan (.\Scripts\Get-ProcessRamUsage.ps1 -ProcessName explorer -UnIt GB)
    }
}

Describe "Impero-Detector"{

}

Describe "Start-FakeWebPage"{
    It "Start 1 process by monitors = 3"{
        (.\Scripts\Start-FakeWebPage.ps1 -Browser chrome -WebsIte etml.ch -WhatIf).Count | Should Be 3
    }
}

Describe "Test-Augmentation" {
    It "15.68 -> 23.59 wIth delta 6.2 = True" {
        .\Scripts\Test-Augmentation.ps1 -OldValue 15.68 -NewValue 23.59 -MinDelta 6.2 | Should Be true
    }

    It "15.68 -> 23.59 wIth delta 11 = False" {
        .\Scripts\Test-Augmentation.ps1 -OldValue 15.68 -NewValue 23.59 -MinDelta 11  | Should Be false
    }

    It "23.59 -> 15.68 wIth delta 3 = False" {
        .\Scripts\Test-Augmentation.ps1 -OldValue 23.59 -NewValue 15.68 -MinDelta 3 | Should Be false
    }
}

Describe "Compile-Project"{
    
}