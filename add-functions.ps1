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

$functions = @(
    @{
        "Function ID" = "F0"
        "Function Statement" = "Provide persistent elevated observation from naval vessel"
        "Type" = "essential"
        "Working Principle" = "System-level integration"
        "Physical Effect" = "N/A (system function)"
        "Notes" = "Overall system function"
    },
    @{
        "Function ID" = "F1"
        "Function Statement" = "Generate aerodynamic lift and thrust"
        "Type" = "essential"
        "Working Principle" = "Quadrotor propulsion"
        "Physical Effect" = "Electromagnetic induction + Aerodynamics"
        "Notes" = "Primary propulsion function"
    },
    @{
        "Function ID" = "F1.1"
        "Function Statement" = "Convert electrical energy to rotational energy"
        "Type" = "essential"
        "Working Principle" = "Brushless DC Outrunner Motor"
        "Physical Effect" = "Lorentz force on current-carrying conductors"
        "Notes" = "T-Motor U8 II x4"
    },
    @{
        "Function ID" = "F2"
        "Function Statement" = "Control attitude and position"
        "Type" = "essential"
        "Working Principle" = "MEMS IMU + EKF Sensor Fusion"
        "Physical Effect" = "MEMS capacitive sensing + PID control"
        "Notes" = "Flight control system"
    },
    @{
        "Function ID" = "F3"
        "Function Statement" = "Deliver power via tether"
        "Type" = "essential"
        "Working Principle" = "High-Voltage Tethered Power Delivery"
        "Physical Effect" = "Ohmic conduction"
        "Notes" = "48V DC enables 150m range. KEY DIFFERENTIATOR."
    },
    @{
        "Function ID" = "F4"
        "Function Statement" = "Acquire and stabilize imagery"
        "Type" = "essential"
        "Working Principle" = "Active 3-Axis Gimbal Stabilization"
        "Physical Effect" = "Gyroscopic stabilization + PID control"
        "Notes" = "Dual EO/IR payload"
    },
    @{
        "Function ID" = "F5"
        "Function Statement" = "Transmit data via tether"
        "Type" = "essential"
        "Working Principle" = "Fiber Optic Data Link"
        "Physical Effect" = "Total internal reflection"
        "Notes" = "EMI immune, secure, high bandwidth"
    },
    @{
        "Function ID" = "F6"
        "Function Statement" = "Manage tether deployment"
        "Type" = "auxiliary"
        "Working Principle" = "Active Tension Control + Swivel Joint"
        "Physical Effect" = "Closed-loop force control"
        "Notes" = "Prevents tether twist and maintains tension"
    },
    @{
        "Function ID" = "F6.4"
        "Function Statement" = "Prevent tether twist"
        "Type" = "auxiliary"
        "Working Principle" = "Hybrid Electro-Optical Swivel Joint"
        "Physical Effect" = "Rotary decoupling with slip ring + FRJ"
        "Notes" = "Custom indigenous development. KEY IP."
    },
    @{
        "Function ID" = "F7"
        "Function Statement" = "Provide emergency power"
        "Type" = "auxiliary"
        "Working Principle" = "Battery backup with auto-failsafe"
        "Physical Effect" = "Electrochemical energy storage"
        "Notes" = "5-min reserve for controlled descent"
    }
)

foreach ($func in $functions) {
    $body = @{
        fields = $func
    } | ConvertTo-Json -Depth 5

    try {
        $result = Invoke-RestMethod -Uri "$baseUrl/RE_Functions" -Method Post -Headers $headers -Body $body
        Write-Host "Added: $($func['Function ID']) - $($func['Function Statement'])" -ForegroundColor Green
    } catch {
        Write-Host "Error adding $($func['Function ID']): $_" -ForegroundColor Red
    }
}

Write-Host "`nAll functions added to RE_Functions table." -ForegroundColor Cyan
