$dateFormat = "yyyy/MM/dd hh:mm tt"

#super cool ascii header
. "$dir\header.ps1"

#the file in which the tasks are defined
if (Test-Path ($taskFile = "$dir\tasks.ps1")) {
    . $taskFile
} else {
    Write-Host "Task file not found. Rename tasks.example.ps1 to tasks.ps1." -ForegroundColor Red
    exit 1
}

#make sure some tasks have been defined
if ($tasks.Length -eq 0) {
    Write-Host "No tasks have been defined. Define tasks in tasks.ps1." -ForegroundColor Red
    exit 1
}