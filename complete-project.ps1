# Requires: $env:AIRTABLE_API_KEY and $env:AIRTABLE_BASE_ID
# Usage: .\complete-project.ps1 -RecordId "recXXXXXX"
param(
    [Parameter(Mandatory=$true)]
    [string]$RecordId
)

if (-not $env:AIRTABLE_API_KEY -or -not $env:AIRTABLE_BASE_ID) {
    Write-Host "ERROR: Set AIRTABLE_API_KEY and AIRTABLE_BASE_ID environment variables" -ForegroundColor Red
    exit 1
}
$headers = @{
    "Authorization" = "Bearer $env:AIRTABLE_API_KEY"
    "Content-Type" = "application/json"
}
$baseUrl = "https://api.airtable.com/v0/$env:AIRTABLE_BASE_ID"

# Update project status to COMPLETE
$projectUpdate = @{
    fields = @{
        "Status" = "COMPLETE"
        "Notes" = "Full D-M-I-R analysis completed. 10 components cataloged, 22 functions identified, 8 working principles documented, 8 recommendations generated, 7 lessons learned captured."
    }
} | ConvertTo-Json -Depth 5

try {
    $result = Invoke-RestMethod -Uri "$baseUrl/RE_Projects/$RecordId" -Method Patch -Headers $headers -Body $projectUpdate
    Write-Host "Project status updated to COMPLETE" -ForegroundColor Green
} catch {
    Write-Host "Error updating project: $_" -ForegroundColor Red
}

# Add lessons learned
$lessons = @(
    @{
        "Title" = "Tethered Power Changes Everything"
        "Category" = "paradigm"
        "Insight" = "Tethered power fundamentally changes the design paradigm from energy-constrained to power-limited. This shifts optimization from minimizing weight to maximizing power handling capability."
        "Action" = "Apply 'unlimited endurance' thinking to tethered system designs"
        "Applicability" = "All tethered aerial/underwater systems"
        "Status" = "identified"
        "Priority" = "high"
    },
    @{
        "Title" = "Indigenous IP on Differentiators Only"
        "Category" = "paradigm"
        "Insight" = "Strategic indigenous development should focus on differentiating technology (tether system) while using COTS for commodity subsystems (propulsion, flight control). This maximizes R&D leverage."
        "Action" = "Apply focused IP strategy to future developments"
        "Applicability" = "All indigenous development programs"
        "Status" = "identified"
        "Priority" = "high"
    },
    @{
        "Title" = "Early Regulatory Assessment"
        "Category" = "process"
        "Insight" = "ITAR/EAR assessment should occur in DIAGNOSIS phase, not INTERVENTION. Earlier identification of export-controlled components prevents downstream redesign."
        "Action" = "Add regulatory checklist to diagnosis template"
        "Applicability" = "All military system analyses"
        "Status" = "in_progress"
        "Priority" = "medium"
    },
    @{
        "Title" = "48V is the Tether Sweet Spot"
        "Category" = "technical"
        "Insight" = "48V DC is optimal for tethered drones up to 200m: high enough to reduce losses, low enough for safety, and matches EV/telecom component ecosystems."
        "Action" = "Use 48V as baseline for new tethered designs"
        "Applicability" = "Tethered UAV, ROV systems"
        "Status" = "implemented"
        "Priority" = "high"
    },
    @{
        "Title" = "Fiber Optic Through Rotary Joints"
        "Category" = "technical"
        "Insight" = "Fiber rotary joints (FRJs) are mature technology that enables high-bandwidth data through rotating interfaces. Combined with slip rings, they solve the tethered rotation problem elegantly."
        "Action" = "Catalog FRJ suppliers and specifications"
        "Applicability" = "Rotating platforms, radar pedestals"
        "Status" = "identified"
        "Priority" = "medium"
    }
)

foreach ($lesson in $lessons) {
    $body = @{
        fields = $lesson
    } | ConvertTo-Json -Depth 5

    try {
        $result = Invoke-RestMethod -Uri "$baseUrl/RE_Lessons_Learned" -Method Post -Headers $headers -Body $body
        Write-Host "Added lesson: $($lesson['Title'])" -ForegroundColor Green
    } catch {
        Write-Host "Error adding lesson: $_" -ForegroundColor Red
    }
}

Write-Host "`nProject completed and lessons learned captured!" -ForegroundColor Cyan
