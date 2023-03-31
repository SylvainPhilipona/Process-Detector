# Load the configs
$Config = .\Configs.ps1
$Icons = .\Icons.ps1

# Variables
[float]$OldValue = 0
[bool]$FirstIteration = $true
[bool]$global:stop = $false

# Load the windows form assembly
# Create a notify icon that is display at bottom right
# This notification allow the user to stop the script when the console is hidden
Add-Type -AssemblyName System.Windows.Forms
$notification = New-Object System.Windows.Forms.NotifyIcon

$notification.Icon = [convert]::FromBase64String($Icons.Icon)
$notification.Text = "Exit Program"
$notification.add_Click{
    $notification.Dispose()
    $global:stop = $true
}
$notification.Visible = $true

# Repeat the iterations while the user didtn't close the program
while(!($global:stop)){

    # Get the ram usage of the parameters defined process
    $RamUsage = [float](.\Get-ProcessRamUsage.ps1 -ProcessName $Config.Data.Name -Unit $Config.Data.Unit)[0]

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
    if(.\Test-Augmentation.ps1 -OldValue $OldValue -NewValue $RamUsage -MinDelta $Config.Data.MinDelta){
        Write-Host "RAM use increased --> $RamUsage" -ForegroundColor Green

        .\Start-FakeWebPage.ps1 -Website $Config.Trigger.Website -Browser $Config.Trigger.Browser
    }
    else{
        Write-Host "RAM usage --> $RamUsage" -ForegroundColor Red
    }

    # Set the old value as current.
    # So in the next iteration the current value will be the last iteration value
    $OldValue = $RamUsage
    Start-Sleep -Milliseconds $Config.Data.IterationDuration
}