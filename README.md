# Process-Detector
## Be aware that this software is a proof of concept and is intended for educational use only.
This program detect the use of a specific software with a powershell script.

The program read the amount of RAM usage that the process from a software uses. This is done every 300ms.<br>
The RAM in use is compared with the value of the last iteration to detect an increase.<br>
![image](https://user-images.githubusercontent.com/87760278/229086202-7d244a61-5eac-4829-926a-2af31dcc6587.png)<br>

When an increase is detected, the script launch in fullscreen on each monitors a web-browser with a website opened.<br>
This way the person that watch your screen will not see what you were doing.

The script run on background so it's almost undetectable. The only visible trace is a small icon in the notify bar.<br>
With this icon you can easily stop the script execution at any moment.<br>
![image](https://user-images.githubusercontent.com/87760278/229078207-e0ce5d6a-86f1-4f5c-87de-fa828e40e575.png)
![image](https://user-images.githubusercontent.com/87760278/229078633-76b7055e-e21e-49e7-a181-7bf56b140592.png)
<br><br><br>


# How to use this project
The first step is to download the program from this GitHub.<br>
Once downloaded and un-zipped you will find the folder 'Process-Detector'.<br>
You can copy this folder wherever you want.<br>
To execute the program you just have to double-click on the 'start.bat' file.<br>
![image](https://github.com/SylvainPhilipona/Process-Detector/assets/87760278/202c56cf-39b7-4e72-bc79-0a835719dcb8)
<img src="https://user-images.githubusercontent.com/87760278/229081461-717e4b11-afc9-45a4-a92d-1a9e19e459a7.png" width="10%" height="10%"></img>
![image](https://github.com/SylvainPhilipona/Process-Detector/assets/87760278/d345a1c9-0d0c-4875-895b-e03613fc22f2)<br><br>


# How to change configurations
If you want to change the project configuration, you can do it in the file .\Scripts\Configs.ps1.<br>
![image](https://github.com/SylvainPhilipona/Process-Detector/assets/87760278/be5e595f-a854-4eff-a567-966fc76e8c68)<br>

You can change any values you want.<br>
All data are examples
```PowerShell
return [PSCustomObject]@{
    Data = @{
        Name = "ImperoClient"
        MinDelta = 10
        Unit = "MB"
        IterationDuration = 300
    }

    Trigger = @{
        Browser = "msedge"
        Website = "https://enseignement.section-inf.ch/"
        Timeout = 5000
    }
}
```
After you did your changes, you will have te recompile the project.<br>
To do this you just have to execute the script 'Compile-Project.ps1'. It will update the project with your new configs.<br>
![image](https://github.com/SylvainPhilipona/Process-Detector/assets/87760278/6bd668ed-1609-4b27-884a-2f52154e779f)
