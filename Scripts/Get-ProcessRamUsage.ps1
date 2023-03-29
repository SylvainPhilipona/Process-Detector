# 29.03.2023

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