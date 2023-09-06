$url = "https://www.resplendence.com/download/LatencyMon.exe"
# Define the path where the downloaded file will be saved
& "MKDIR" ".\TEMP"

$outputFilePath = ".\TEMP\LatencyMon.exe"

# Use Invoke-WebRequest to download the file
Invoke-WebRequest -Uri $url -OutFile $outputFilePath

$Command = ".\TEMP\LatencyMon.exe"
$Parms = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART"

$Parms = $Parms.Split(" ")
& "$Command" $Parms
