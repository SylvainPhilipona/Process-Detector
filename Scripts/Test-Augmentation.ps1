<#
.NOTES
    *****************************************************************************
    Name:	Test-Augmentation.ps1
    Author:	Sylvain Philipona
    Date:	29.03.2023
 	*****************************************************************************
    Modifications
 	Date  : 30.03.2023
 	Author: Sylvain Philipona
 	Reason: UTF-8 with BOM encoding
 	*****************************************************************************
.SYNOPSIS
    Test the value augmentation
 	
.DESCRIPTION
    Test if the augmentation between 2 values defined in parameters has augmented of minimum the delta which is also defined in parameters
  	
.PARAMETER OldValue
    The old value to compare with the new

.PARAMETER NewValue
    The new value to compare with the old

.PARAMETER MinDelta
    The minumum augmentation to detect
 	
.OUTPUTS
	A boolean value according to the values in parameters

.EXAMPLE
    .\Test-Augmentation.ps1 -OldValue 15.68 -NewValue 23.59 -MinDelta 6.2

    True

.EXAMPLE
    .\Test-Augmentation.ps1 -OldValue 15.68 -NewValue 23.59 -MinDelta 11 

    False

.EXAMPLE
    .\Test-Augmentation.ps1 -OldValue 23.59 -NewValue 15.68 -MinDelta 3

    False

#>

# Script parameters
param(
    [Parameter(Position=0)]
    [float]$OldValue,

    [Parameter(Position=1)]
    [float]$NewValue,

    [Parameter(Position=2)]
    [float]$MinDelta
)

# Check if the new value minus the old value is less than the minimum delta
# Eg.
#   New Value : 25
#   Old Value : 8
#   Min Delta : 3
#   (25 - 8 < 3) = False. 
#   The augmentation was greater than the delta. The value 'True' will be returned
if(($NewValue - $OldValue) -lt $MinDelta){
    return $false
}

return $true