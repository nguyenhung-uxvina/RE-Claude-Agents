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

$components = @(
    @{
        "Part Number" = "T-MOTOR-U8-II"
        "Name" = "Brushless Motor U8 II"
        "Type" = "cots"
        "Material" = "Aluminum/Copper"
        "Manufacturer" = "T-Motor"
        "Country of Origin" = "China"
        "Notes" = "100KV heavy-lift motor. Qty: 4 per aircraft."
    },
    @{
        "Part Number" = "T-MOTOR-FLAME-80A"
        "Name" = "Electronic Speed Controller"
        "Type" = "cots"
        "Material" = "PCB Assembly"
        "Manufacturer" = "T-Motor"
        "Country of Origin" = "China"
        "Notes" = "80A ESC, 48V capable. Qty: 4 per aircraft."
    },
    @{
        "Part Number" = "CUBE-ORANGE-PLUS"
        "Name" = "Flight Controller"
        "Type" = "cots"
        "Material" = "PCB Assembly"
        "Manufacturer" = "CubePilot"
        "Country of Origin" = "Hong Kong/China"
        "Notes" = "ArduPilot autopilot with triple IMU redundancy."
    },
    @{
        "Part Number" = "TOD-TETHER-001"
        "Name" = "Hybrid Tether Cable"
        "Type" = "custom"
        "Material" = "Copper/Fiber/Kevlar composite"
        "Manufacturer" = "Indigenous"
        "Country of Origin" = "Vietnam"
        "Notes" = "6mm diameter. Power + fiber optic + strength member. 150m max."
    },
    @{
        "Part Number" = "TOD-SWIVEL-001"
        "Name" = "Tether Swivel Joint"
        "Type" = "custom"
        "Material" = "Stainless Steel 316"
        "Manufacturer" = "Indigenous"
        "Country of Origin" = "Vietnam"
        "Notes" = "8-conductor slip ring + 2 fiber rotary joint. Prevents tether twist."
    },
    @{
        "Part Number" = "TOD-REEL-001"
        "Name" = "Motorized Tether Reel"
        "Type" = "custom"
        "Material" = "Aluminum/Steel"
        "Manufacturer" = "Indigenous"
        "Country of Origin" = "Vietnam"
        "Notes" = "Auto-tension control. Part of ground station."
    },
    @{
        "Part Number" = "FLIR-VUE-PRO-R"
        "Name" = "Thermal Camera"
        "Type" = "cots"
        "Material" = "Electronic Assembly"
        "Manufacturer" = "Teledyne FLIR"
        "Country of Origin" = "USA"
        "Notes" = "Radiometric thermal camera. ITAR/EAR controlled."
    },
    @{
        "Part Number" = "TOD-GIMBAL-001"
        "Name" = "3-Axis Gimbal Assembly"
        "Type" = "custom"
        "Material" = "Aluminum/Carbon Fiber"
        "Manufacturer" = "Indigenous"
        "Country of Origin" = "Vietnam"
        "Notes" = "Storm32 based controller. Supports dual EO/IR payload."
    },
    @{
        "Part Number" = "VICOR-VRM-48-12"
        "Name" = "DC-DC Converter"
        "Type" = "cots"
        "Material" = "Electronic Module"
        "Manufacturer" = "Vicor"
        "Country of Origin" = "USA"
        "Notes" = "48V to 12V, 100W. High efficiency for tethered operation."
    },
    @{
        "Part Number" = "TOD-FRAME-001"
        "Name" = "Carbon Fiber Airframe"
        "Type" = "custom"
        "Material" = "Carbon Fiber Composite"
        "Manufacturer" = "Indigenous"
        "Country of Origin" = "Vietnam"
        "Notes" = "X-configuration quadrotor frame. Marine-grade hardware."
    }
)

foreach ($comp in $components) {
    $body = @{
        fields = $comp
    } | ConvertTo-Json -Depth 5

    try {
        $result = Invoke-RestMethod -Uri "$baseUrl/RE_Components" -Method Post -Headers $headers -Body $body
        Write-Host "Added: $($comp['Name'])" -ForegroundColor Green
    } catch {
        Write-Host "Error adding $($comp['Name']): $_" -ForegroundColor Red
    }
}

Write-Host "`nAll components added to RE_Components table." -ForegroundColor Cyan
