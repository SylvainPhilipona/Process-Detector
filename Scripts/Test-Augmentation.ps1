# 29.03.2023

param(
    [Parameter(Position=0)]
    [float]$OldValue,

    [Parameter(Position=1)]
    [float]$NewValue,

    [Parameter(Position=2)]
    [float]$MinDelta
)

if(($NewValue - $OldValue) -lt $MinDelta){
    return $false
}

return $true