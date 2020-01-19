#the directory in which this script resides
$dir = Split-Path -Parent $MyInvocation.MyCommand.Definition

#include the settings file
. "$dir\settings.ps1"

#stop the script if any errors occurred in included files
if ($LastExitCode) { exit }

#infinite loop
while (1) {

    #set the target time (round up to the nearest hour)
    $next = (Get-Date "$(($now = Get-Date).Year)/$($now.Month)/$($now.Day) $($now.Hour)`:00:00").AddHours(1)

    #wait until the next hour
    While ((Get-Date) -lt $next) { Start-Sleep -S 1 }

    #write the current time
    Write-Host "$($now.ToString($dateFormat))" -ForegroundColor Cyan

    #loop through the tasks and run those that need to be run at this hour
    foreach ($task in $tasks) {

        #skip this task if it doesn't need to be run at this hour
        if ($task.time -ne "hourly" -and $task.time -notcontains $now.Hour) { continue }

        #escape spaces in the path
        $path = $task.path.Replace(" ", "`` ")

        #write the name of the task to the console
        Write-Host "`t$($task.name)"

        #use a try block so an uncaught exception in the task doesn't kill the scheduler
        try {

            #run the task on the local machine
            if ($task.remote -eq $false) { Invoke-Expression $path }
        
            #run the task on a remote machine
            else {

                #start a session on the remote machine
                $session = New-PSSession -ComputerName $task.remote

                #define the script block that runs the task
                $block = {
                    param($path)
                    Invoke-Expression $path
                }

                #run the task!
                Invoke-Command -Session $session -ScriptBlock $block -ArgumentList $path
            }
        }
        
        #if the task failed, write error message to console
        catch {
            Write-Host "`t`t$($_.Exception.Message)" -ForegroundColor Red
        }

        #end the session on the remote machine
        if ($task.remote -ne $false) {
            Remove-PSSession -Session $session
        }
    }
}