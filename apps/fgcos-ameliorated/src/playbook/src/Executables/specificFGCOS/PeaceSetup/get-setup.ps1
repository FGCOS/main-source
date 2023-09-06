# Define the URL for the latest release's API
$latestReleaseApiUrl = "https://versaweb.dl.sourceforge.net/project/peace-equalizer-apo-extension/PeaceSetup.exe"

# Download the asset
Invoke-WebRequest -Uri $latestReleaseApiUrl -OutFile "./Setup.exe"
# Invoke-Expression -Command "./Setup.exe /qn"

