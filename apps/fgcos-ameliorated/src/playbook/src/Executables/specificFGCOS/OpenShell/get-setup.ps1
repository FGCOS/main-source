# Define the URL for the latest release's API
$latestReleaseApiUrl = "https://api.github.com/repos/Open-Shell/Open-Shell-Menu/releases/latest"

# Fetch the JSON data from the GitHub API for the latest release
$releaseData = Invoke-RestMethod -Uri $latestReleaseApiUrl

# Extract the assets list
$assets = $releaseData.assets

# Initialize a variable for the setup file URL
$setupFileUrl = ""

# Loop through the assets to find the setup file URL
foreach ($asset in $assets) {
  if ($asset.name -like '*Setup*.exe') {
    $setupFileUrl = $asset.browser_download_url
    break
  }
}

# Check and print the setup file URL
if ($setupFileUrl -ne "") {
  # Download the asset
  Invoke-WebRequest -Uri $setupFileUrl -OutFile "./Setup.exe"
  Invoke-Expression -Command "./Setup.exe /qn"
}
else {
  Write-Host "Setup file not found in the latest release."
}
