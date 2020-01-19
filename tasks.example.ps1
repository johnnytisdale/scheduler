$tasks = @(
    <#
    [PSCustomObject]@{
        name   = "";        #name your task
        path   = "";        #the absolute path to the script
        remote = $false;    #if the task should be run on a remote machine, enter machine name here
        time   = "hourly"   #if the task should only be run at specific times, enter array of integers
    };
    #>
)