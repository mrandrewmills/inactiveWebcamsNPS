<#
.SYNOPSIS
    Fetches all inactive webcams from the National Park Service (NPS) API.

.DESCRIPTION
    This script queries the NPS Webcams API twice:
    - First, it retrieves the total number of webcams with limit=1.
    - Then it requests all webcams at once using that total.
    It filters the results to only include webcams with a status of "Inactive",
    and outputs selected fields including the related park names.

.NOTES
    Requires an environment variable named 'NPS_API_KEY' to be set.

.EXAMPLE
    .\Get-InactiveNPSWebcams.ps1
    .\Get-InactiveNPSWebcams.ps1 > inactive_webcams.txt
#>

# Set API key
$apiKey = $env:NPS_API_KEY

if (-not $apiKey) {
    Write-Error "API key not found. Please set the NPS_API_KEY environment variable."
    exit 1
}

# Step 1: Get total number of webcams
$initialResponse = Invoke-RestMethod -Uri "https://developer.nps.gov/api/v1/webcams?limit=1&api_key=$apiKey"
$total = [int]$initialResponse.total

# Step 2: Get all webcams
$fullResponse = Invoke-RestMethod -Uri "https://developer.nps.gov/api/v1/webcams?limit=$total&api_key=$apiKey"

# Step 3: Filter inactive webcams and format output
$inactiveWebcams = $fullResponse.data | Where-Object { $_.status -eq "Inactive" } | ForEach-Object {
    [PSCustomObject]@{
        Id            = $_.id
        Url           = $_.url
        Title         = $_.title
        Status        = $_.status
        StatusMessage = $_.statusMessage
        Parks         = ($_.relatedParks | ForEach-Object { $_.name }) -join ", "
    }
}

# Step 4: Output to console or allow redirection
$inactiveWebcams | ForEach-Object {
    "Id: $($_.id)"
    "URL: $($_.url)"
    "Title: $($_.title)"
    "Status: $($_.status)"
    "Status Message: $($_.statusMessage)"
    "Related Parks: $($_.Parks)"
    "----------------------------------------"
}
