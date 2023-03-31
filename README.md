# Impero-Detector
This program detect the use of the software "IMPERO" with a powershell script.

The program read the amount of RAM that the process 'ImperoClient' uses. This is done every 300ms.<br>
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
Once downloaded and un-zipped you will find the folder 'Impero-Detector'.<br>
You can copy this folder wherever you want.<br>
To execute the program you just have to double-click on the 'start.bat' file.<br>
![image](https://user-images.githubusercontent.com/87760278/229080477-7bfdb16c-7214-4201-9e09-7291ac700a27.png)
<img src="https://user-images.githubusercontent.com/87760278/229081461-717e4b11-afc9-45a4-a92d-1a9e19e459a7.png" width="10%" height="10%"></img>
![image](https://user-images.githubusercontent.com/87760278/229082092-d3e8bb10-f278-4a25-8de6-db12562c3f98.png)<br><br>


# How to change configurations
If you want to change the project configuration, you can do it in the file .\Scripts\Configs.ps1.<br>
![image](https://user-images.githubusercontent.com/87760278/229087848-f6c27fe8-b5d8-477f-955b-5089d3fd1a6e.png)<br>

You can change any values you want.
```
return [PSCustomObject]@{
    Data = @{
        Name = "ImperoClient"
        MinDelta = 20
        Unit = "MB"
        IterationDuration = 300
    }

    Trigger = @{
        Browser = "msedge"
        Website = "www.joca.ch"
    }
}
```
After you did your changes, you will have te recompile the project.<br>
To do this you just have to execute the script 'Compile-Project.ps1'. It will update the project with your new configs.
![image](https://user-images.githubusercontent.com/87760278/229089529-5fdeca86-4f2a-4350-b294-25931b87e27b.png)
