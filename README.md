 # Scheduler
 A PowerShell task scheduler.

 ## Prerequisites
 Developed and tested in PowerShell 5.1.18362.145. May work in earlier versions of PowerShell,
but use at your own risk.

 ## Installation
 Simply place the files in a directory.

 ## Configuration
 Define your tasks in tasks.example.ps1 and rename the file to tasks.ps1.

 The tasks are stored as an array of objects. Each object has the following properties:

 ### name
 An arbitrary, human-readable identifier. Call it whatever you want.

 ### path
 The absolute file path of the task.

 ### remote
 If the task should be run locally, set this to <code>$false</code>. If the task should be run 
in a session on another computer on your network, enter the name of that computer here. In 
this case, the path you specified is assumed to be relative to the remote computer.
 For example, if <code>path</code> is set to "C:\powershell\task1.ps1" and <code>remote</code> 
is set to "MyServer", then task1.ps1 is assumed to exist on the C: drive of MyServer, '''NOT''' 
the computer from which the scheduler is being executed.

 ### time
 If the task should be run hourly, set this to "hourly". If the task should be run only at specific 
times, set this to an array of values for hours in 24-hour time. For example, if you want the task 
to run at midnight, 7 AM, and 1 PM, set this to <code>@(0, 7, 13)</code>.

 ## Usage
 ```
 powershell scheduler.ps1
 ```

 ## Authors
 '''Johnny Tisdale''' - [github](github.com/johnnytisdale) | [website](johnnytisdale.com) 
 
 ## License
 This project is licensed under the ISC License. See [LICENSE.md](LICENSE.md) for details.
 
 ## Acknowledgements
 * [Billie Thompson AKA PurpleBooth](https://github.com/PurpleBooth) - README template
