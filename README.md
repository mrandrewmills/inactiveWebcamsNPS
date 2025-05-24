# Inactive NPS Webcams Finder

A quick & dirty PowerShell script to retrieve and display all **inactive** webcams from the U.S. National Park Service (NPS) API.

## 🔍 What It Does

1. Fetches a single record from the NPS webcams endpoint to determine the total number of webcam entries.
2. Makes a second call to retrieve **all webcam records** in one go.
3. Filters for webcams with `"status": "Inactive"`.
4. Outputs key details for each inactive webcam in a **line-by-line format**, optimized for console output or redirection to a text file.

## 🧪 Sample Output

```
Id: 12345-EXAMPLE
URL: https://www.nps.gov/media/webcam/view.htm?id=12345-EXAMPLE
Title: Park Entrance Camera
Status: Inactive
Status Message: Temporarily offline for maintenance.
Related Parks: Grand Canyon
----------------------------------------
```

## ⚙️ Requirements

- PowerShell 5.x or newer
- [NPS API Key](https://www.nps.gov/subjects/developer/get-started.htm)

## 🔐 Setup

Set your API key in the environment variable `NPS_API_KEY` (optional, see note below):

```powershell
$env:NPS_API_KEY = "your_actual_api_key"
```

## 🚀 Running the Script

```powershell
.\inactiveWebcams.ps1
```

To redirect output to a file:

```powershell
.\inactiveWebcams.ps1 > inactive-webcams.txt
```

## 📝 Fields Displayed

- `id`
- `url`
- `title`
- `status`
- `statusMessage`
- `relatedParks` (flattened list of park names)

## 🧼 Caveats

- The script assumes that retrieving all webcam data in one call is performant and allowed by the API (limit set to match total).
- No retries or paging logic is included — this is intentionally minimal.

## 📄 License

MIT or Unlicensed – use and modify as you wish.
