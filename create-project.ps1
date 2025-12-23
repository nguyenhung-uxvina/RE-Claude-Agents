# Requires: $env:AIRTABLE_API_KEY and $env:AIRTABLE_BASE_ID
if (-not $env:AIRTABLE_API_KEY -or -not $env:AIRTABLE_BASE_ID) {
    Write-Host "ERROR: Set AIRTABLE_API_KEY and AIRTABLE_BASE_ID environment variables" -ForegroundColor Red
    exit 1
}
$headers = @{
    "Authorization" = "Bearer $env:AIRTABLE_API_KEY"
    "Content-Type" = "application/json"
}
$baseUrl = "https://api.airtable.com/v0/$env:AIRTABLE_BASE_ID"

$body = @{
    fields = @{
        "System" = "Tethered Observation Drone"
        "Status" = "DIAGNOSIS"
        "Objective" = "understand"
        "Origin Country" = "Vietnam (Indigenous Development)"
        "Priority" = "high"
        "Notes" = "Full D-M-I-R analysis for naval tethered observation drone system. Goal: Optimize design using systems thinking and RE methodology."
    }
} | ConvertTo-Json -Depth 5

$result = Invoke-RestMethod -Uri "$baseUrl/RE_Projects" -Method Post -Headers $headers -Body $body
Write-Host "Project created: $($result.id)"
$result | ConvertTo-Json
