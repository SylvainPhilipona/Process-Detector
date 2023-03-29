return [PSCustomObject]@{
    Conf = @{
        Name = "ImperoClient"
        MinDelta = 5
        Unit = "MB"
        IterationDuration = 300
    }

    Trigger = @{
        Browser = "msedge"
        Website = "www.joca.ch"
    }
}