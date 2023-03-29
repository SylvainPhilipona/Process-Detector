[float]$OldValue = 0
[bool]$FirstIteration = $true
while($true){

    # Get the ram usage of the notepad process
    $RamUsage = [float](.\Get-ProcessRamUsage.ps1 -ProcessName notepad -Unit KB)[0]

    # On the first iteration do nothing
    # Otherrise the augentation from 0 to the ram usage will be instant detected
    if($FirstIteration){
        $OldValue = $RamUsage
        $FirstIteration = $false
        continue
    }



    if(.\Test-Augmentation.ps1 -OldValue $OldValue -NewValue $RamUsage -MinDelta 5){
        Write-Host "Augmentation de l'utilisation de la ram --> $RamUsage" -ForegroundColor Green
    }
    else{
        Write-Host "Non --> $RamUsage" -ForegroundColor Red
    }

    $OldValue = $RamUsage
    Start-Sleep -Milliseconds 300
}