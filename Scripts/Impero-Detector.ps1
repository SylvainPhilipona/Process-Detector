param(
    $name = "ImperoClient"
)

[float]$OldValue = 0
[bool]$FirstIteration = $true
while($true){

    # Get the ram usage of the parameters defined process
    $RamUsage = [float](.\Get-ProcessRamUsage.ps1 -ProcessName $name -Unit MB)[0]

    # On the first iteration do nothing
    # Otherrise the augentation from 0 to the ram usage will be instant detected
    if($FirstIteration){
        $OldValue = $RamUsage
        $FirstIteration = $false
        continue
    }

    # Test if the ram usage has augmented from the last iteration
    # The MinDelta is the minimum augmentation that we will detect
    # The usual usage depand of the PC. The values are the ones detected on my PC
    # However the augmentation seems to be the same no matter what computer
    # This value is calibrated by tests
    #   Usual usage               : ~ 213-218 MB
    #   Usage on screen recording : 
    # 
    if(.\Test-Augmentation.ps1 -OldValue $OldValue -NewValue $RamUsage -MinDelta 7){
        Write-Host "Augmentation de l'utilisation de la ram --> $RamUsage" -ForegroundColor Green
    }
    else{
        Write-Host "Non --> $RamUsage" -ForegroundColor Red
    }

    # Set the old value as current.
    # So in the next iteration the current value will be the last iteration value
    $OldValue = $RamUsage
    Start-Sleep -Milliseconds 300
}