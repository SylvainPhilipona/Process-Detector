<#
.NOTES
    *****************************************************************************
    Name:	Unit-Testing.ps1
    Author:	Sylvain Philipona
    Date:	30.03.2023
 	*****************************************************************************
    Modifications
 	Date  : 31.03.2023
 	Author: Sylvain Philipona
 	Reason: Adding more tests
 	*****************************************************************************
.SYNOPSIS
    Unit tests
 	
.DESCRIPTION
    This file list all units tests
 	
.OUTPUTS
	The result of units tests

.EXAMPLE
    .\Unit-Testing.ps1

    Starting discovery in 1 files.
    Discovery found 9 tests in 19ms.
    Running tests.
    [+] E:\Impero-Detector\Unit-Testing.ps1 293ms (199ms|77ms)
    Tests completed in 301ms
    Tests Passed: 9, Failed: 0, Skipped: 0 NotRun: 0

.LINK
    https://pester.dev/docs/quick-start
    https://pester.dev/docs/v4/usage/assertions

#>

# Install the module if not installed
[string]$Version = "5.3.1"
if(!((Get-Module -Name Pester).Version -eq $Version)){
    Install-Module -Name Pester -Scope CurrentUser -RequiredVersion $Version -Force -SkipPublisherCheck
}

# Configs.ps1
Describe "Configs"{
    It "Process name = ImperoClient"{
        (.\Scripts\Configs.ps1).Data.Name | Should -Be "ImperoClient"
    }
}

# Icons.ps1
Describe "Icons"{
    It "Icon = not null"{
        (.\Scripts\Icons.ps1).Icon | Should -Not -Be $null
    }
}

# Get-ProcessRamUsage.ps1
Describe "Get-ProcessRamUsage"{
    It "Notepad is closed = 0"{
        .\Scripts\Get-ProcessRamUsage.ps1 -ProcessName notepad -Unit Byte | Should -Be 0
    }

    It "Explorer is > than 0 MB"{
        .\Scripts\Get-ProcessRamUsage.ps1 -ProcessName explorer -Unit MB | Should -BeGreaterThan 0 
    }

    It "Explorer in MB > Explorer in GB"{
        .\Scripts\Get-ProcessRamUsage.ps1 -ProcessName explorer -Unit MB | Should -BeGreaterThan (.\Scripts\Get-ProcessRamUsage.ps1 -ProcessName explorer -Unit GB)
    }
}

# Start-FakeWebPage.ps1
Describe "Start-FakeWebPage"{
    It "Start 1 process by monitors = 3"{
        (.\Scripts\Start-FakeWebPage.ps1 -Browser chrome -Website etml.ch -WhatIf).Count | Should -Be 3
    }
}

# Test-Augmentation.ps1
Describe "Test-Augmentation" {
    It "15.68 -> 23.59 with delta 6.2 = True" {
        .\Scripts\Test-Augmentation.ps1 -OldValue 15.68 -NewValue 23.59 -MinDelta 6.2 | Should -Be true
    }

    It "15.68 -> 23.59 with delta 11 = False" {
        .\Scripts\Test-Augmentation.ps1 -OldValue 15.68 -NewValue 23.59 -MinDelta 11  | Should -Be false
    }

    It "23.59 -> 15.68 with delta 3 = False" {
        .\Scripts\Test-Augmentation.ps1 -OldValue 23.59 -NewValue 15.68 -MinDelta 3 | Should -Be false
    }
}