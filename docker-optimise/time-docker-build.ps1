# remove all docker images and cached layers
docker-purge;

$endtime = 0;
$duration = 0;
# set the start time as a unix timestamp (easy to calculate durations in seconds)
$starttime = [int][double]::Parse((Get-Date -UFormat %s));
# create a variable which will be the line to print
# as we don't know the endtime of a step until the next step
# we have to print the line for the previous step in each iteration
# so this variable sits outside the loop scope so we can build the printable line
$toprint = "$starttime;START";

# take each output line from the docker build command containing "Step"
docker build . --no-cache | Select-String -Pattern "Step" | ForEach-Object {
    # get the end time in unix time, calculate the duration then print the line to console and a log file
    $endtime = [int][double]::Parse((Get-Date -UFormat %s));
    $duration = $endtime - $starttime;
    $toprint = "$toprint;$duration";
    Write-Output $toprint;
    Add-Content buildlog.csv $toprint;

    #setup the next line with the start time and step description
    $starttime = [int][double]::Parse((Get-Date -UFormat %s));
    $toprint = "$starttime;$_";
} 

