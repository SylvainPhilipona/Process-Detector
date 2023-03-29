[float]$OldValue = 0
[bool]$FirstIteration = $true
while($true){

    $RamUsage = [float](.\Get-ProcessRamUsage.ps1 -ProcessName notepad -Unit KB)[0]

    # return
    if(-not $FirstIteration){
        if(.\Test-Augmentation.ps1 -OldValue $OldValue -NewValue $RamUsage -MinDelta 5){
            Write-Host "Augmentation de l'utilisation de la ram --> $RamUsage" -ForegroundColor Green
        }
        else{
            Write-Host "Non --> $RamUsage" -ForegroundColor Red
        }
    }

    $OldValue = $RamUsage
    $FirstIteration = $false
    Start-Sleep -Milliseconds 300
}