# Configuration - Set these environment variables or update values here
$apiKey = $env:AIRTABLE_API_KEY
$baseId = $env:AIRTABLE_BASE_ID

if (-not $apiKey) {
    Write-Host "ERROR: AIRTABLE_API_KEY environment variable not set" -ForegroundColor Red
    Write-Host "Set it with: `$env:AIRTABLE_API_KEY = 'your-api-key'" -ForegroundColor Yellow
    exit 1
}

if (-not $baseId) {
    Write-Host "ERROR: AIRTABLE_BASE_ID environment variable not set" -ForegroundColor Red
    Write-Host "Set it with: `$env:AIRTABLE_BASE_ID = 'your-base-id'" -ForegroundColor Yellow
    exit 1
}

$headers = @{
    'Authorization' = "Bearer $apiKey"
    'Content-Type' = 'application/json'
}
$baseUrl = "https://api.airtable.com/v0/$baseId"

Write-Host "=== Syncing Tethered Drone Project to Airtable ===" -ForegroundColor Cyan

# 1. Create/Update Project Record
Write-Host "`n[1/5] Syncing Project record..." -ForegroundColor Yellow

$projectData = @{
    fields = @{
        'System' = 'Tethered Observation Drone (TOD-2025-001)'
        'Status' = 'COMPLETE'
        'Objective' = 'understand'
        'Origin Country' = 'Vietnam (Indigenous Development)'
        'Priority' = 'high'
        'Notes' = 'Naval observation platform with tethered power and fiber optic data. Full D-M-I-R analysis completed. 72% documentation completeness, 87% validation score.'
    }
} | ConvertTo-Json -Depth 5

try {
    $project = Invoke-RestMethod -Uri "$baseUrl/RE_Projects" -Method Post -Headers $headers -Body $projectData
    Write-Host "  Created project: $($project.id)" -ForegroundColor Green
    $projectRecordId = $project.id
} catch {
    Write-Host "  Error creating project: $_" -ForegroundColor Red
    $projectRecordId = $null
}

# 2. Create Component Records
Write-Host "`n[2/5] Syncing Components..." -ForegroundColor Yellow

$components = @(
    @{name='T-Motor U8 II'; type='COTS'; manufacturer='T-Motor'; part_number='U8-II-100KV'; country='China'}
    @{name='Flame 80A ESC'; type='COTS'; manufacturer='T-Motor'; part_number='Flame-80A'; country='China'}
    @{name='CF Propeller 28x9.2'; type='COTS'; manufacturer='T-Motor'; part_number='CF28x9.2'; country='China'}
    @{name='Cube Orange+ Autopilot'; type='COTS'; manufacturer='CubePilot'; part_number='Cube-Orange+'; country='China/HK'}
    @{name='HERE3+ GPS'; type='COTS'; manufacturer='CubePilot'; part_number='HERE3+'; country='China/HK'}
    @{name='Sony A7R Camera'; type='COTS'; manufacturer='Sony'; part_number='ILCE-7R'; country='Japan'}
    @{name='FLIR Vue Pro R'; type='COTS'; manufacturer='Teledyne FLIR'; part_number='Vue-Pro-R-640'; country='USA'}
    @{name='Vicor DC-DC Converter'; type='COTS'; manufacturer='Vicor'; part_number='VRM-48-12-100'; country='USA'}
    @{name='Hybrid Tether Cable'; type='CUSTOM'; manufacturer='Indigenous'; part_number='TOD-TETHER-001'; country='Vietnam'}
    @{name='Swivel Joint Assembly'; type='CUSTOM'; manufacturer='Indigenous'; part_number='TOD-SWIVEL-001'; country='Vietnam'}
)

$componentCount = 0
foreach ($comp in $components) {
    $compData = @{
        fields = @{
            'Part Number' = $comp.part_number
            'Name' = $comp.name
            'Manufacturer' = $comp.manufacturer
            'Country of Origin' = $comp.country
            'Notes' = "Project: TOD-2025-001 | Type: $($comp.type)"
        }
    } | ConvertTo-Json -Depth 5

    try {
        $result = Invoke-RestMethod -Uri "$baseUrl/RE_Components" -Method Post -Headers $headers -Body $compData
        $componentCount++
        Write-Host "  Created: $($comp.name)" -ForegroundColor Green
    } catch {
        Write-Host "  Error creating $($comp.name): $_" -ForegroundColor Red
    }
}
Write-Host "  Total components synced: $componentCount" -ForegroundColor Cyan

# 3. Create Function Records
Write-Host "`n[3/5] Syncing Functions..." -ForegroundColor Yellow

$functions = @(
    @{id='F0'; statement='Provide persistent elevated observation from naval vessel'; type='Primary'}
    @{id='F1'; statement='Generate aerodynamic lift and thrust'; type='Essential'}
    @{id='F1.1'; statement='Convert electrical energy to rotational energy'; type='Sub'}
    @{id='F1.2'; statement='Convert rotational energy to thrust'; type='Sub'}
    @{id='F2'; statement='Control attitude and position'; type='Essential'}
    @{id='F2.1'; statement='Sense aircraft attitude'; type='Sub'}
    @{id='F2.2'; statement='Sense aircraft position'; type='Sub'}
    @{id='F2.3'; statement='Compute control commands'; type='Sub'}
    @{id='F3'; statement='Deliver power via tether'; type='Essential'}
    @{id='F3.1'; statement='Conduct electrical power through tether'; type='Sub'}
    @{id='F3.2'; statement='Convert voltage levels'; type='Sub'}
    @{id='F4'; statement='Acquire and stabilize imagery'; type='Essential'}
    @{id='F4.1'; statement='Capture visible spectrum imagery'; type='Sub'}
    @{id='F4.2'; statement='Capture thermal imagery'; type='Sub'}
    @{id='F4.3'; statement='Stabilize line of sight'; type='Sub'}
    @{id='F5'; statement='Transmit data via tether'; type='Essential'}
    @{id='F5.1'; statement='Encode video streams'; type='Sub'}
    @{id='F5.3'; statement='Transmit via fiber optic'; type='Sub'}
    @{id='F6'; statement='Manage tether deployment'; type='Auxiliary'}
    @{id='F6.3'; statement='Maintain constant tension'; type='Sub'}
    @{id='F6.4'; statement='Prevent tether twist'; type='Sub'}
    @{id='F7'; statement='Provide emergency power'; type='Auxiliary'}
)

$functionCount = 0
foreach ($func in $functions) {
    $funcData = @{
        fields = @{
            'Function ID' = "TOD-$($func.id)"
            'Function Statement' = $func.statement
            'Notes' = "Project: TOD-2025-001 | Level: $($func.type)"
        }
    } | ConvertTo-Json -Depth 5

    try {
        $result = Invoke-RestMethod -Uri "$baseUrl/RE_Functions" -Method Post -Headers $headers -Body $funcData
        $functionCount++
        Write-Host "  Created: TOD-$($func.id)" -ForegroundColor Green
    } catch {
        Write-Host "  Error creating $($func.id): $_" -ForegroundColor Red
    }
}
Write-Host "  Total functions synced: $functionCount" -ForegroundColor Cyan

# 4. Create Working Principles Records
Write-Host "`n[4/5] Syncing Working Principles..." -ForegroundColor Yellow

$principles = @(
    @{id='WP-01'; name='Brushless DC Outrunner Motor'; effect='Electromagnetic Induction'; category='electrical'; novelty='standard'; confidence=95}
    @{id='WP-02'; name='Fixed-Pitch Propeller'; effect='Aerodynamic Lift'; category='fluid'; novelty='standard'; confidence=95}
    @{id='WP-03'; name='MEMS IMU with Sensor Fusion'; effect='MEMS Inertial Sensing'; category='mechanical'; novelty='standard'; confidence=90}
    @{id='WP-04'; name='High-Voltage Tethered Power Delivery'; effect='Ohmic Conduction'; category='electrical'; novelty='variant'; confidence=85}
    @{id='WP-05'; name='Fiber Optic Data Link'; effect='Total Internal Reflection'; category='optical'; novelty='variant'; confidence=85}
    @{id='WP-06'; name='Active 3-Axis Gimbal Stabilization'; effect='Gyroscopic Stabilization'; category='mechanical'; novelty='standard'; confidence=90}
    @{id='WP-07'; name='Hybrid Electro-Optical Swivel Joint'; effect='Rotary Decoupling'; category='mechanical'; novelty='variant'; confidence=80}
    @{id='WP-08'; name='Active Tension Control System'; effect='Closed-Loop Force Control'; category='mechanical'; novelty='standard'; confidence=85}
)

$wpCount = 0
foreach ($wp in $principles) {
    $wpData = @{
        fields = @{
            'Principle Name' = $wp.name
            'Physical Effect' = $wp.effect
            'Category' = $wp.category
            'Novelty' = $wp.novelty
            'Confidence' = $wp.confidence
            'Source' = "TOD-2025-001 Analysis"
        }
    } | ConvertTo-Json -Depth 5

    try {
        $result = Invoke-RestMethod -Uri "$baseUrl/RE_Working_Principles" -Method Post -Headers $headers -Body $wpData
        $wpCount++
        Write-Host "  Created: $($wp.name)" -ForegroundColor Green
    } catch {
        Write-Host "  Error creating $($wp.name): $_" -ForegroundColor Red
    }
}
Write-Host "  Total principles synced: $wpCount" -ForegroundColor Cyan

# 5. Create Lessons Learned Records
Write-Host "`n[5/5] Syncing Lessons Learned..." -ForegroundColor Yellow

$lessons = @(
    @{title='Tethered Power Paradigm Shift'; category='paradigm'; insight='Tethered power changes design from energy-constrained to power-limited'; action='Apply power budget analysis early in design'; priority='high'}
    @{title='Indigenous IP Focus'; category='paradigm'; insight='Focus indigenous IP on differentiating technology only'; action='Use COTS for commodity functions'; priority='high'}
    @{title='Early Regulatory Assessment'; category='process'; insight='Early regulatory assessment should occur in DIAGNOSIS phase'; action='Add ITAR/EAR checklist to diagnosis template'; priority='medium'}
    @{title='Systematic Supply Chain Mapping'; category='process'; insight='Supply chain mapping should be systematic in diagnosis'; action='Implement component origin tracking from start'; priority='medium'}
    @{title='48V DC Tether Optimization'; category='technical'; insight='48V DC is optimal for tethered drones up to 200m'; action='Standardize on 48V for tether systems'; priority='high'}
    @{title='Fiber Rotary Joint Design'; category='technical'; insight='Fiber rotary joints enable high-bandwidth rotating interfaces'; action='Include fiber-optic swivel in tethered designs'; priority='medium'}
    @{title='Emergency Power Requirement'; category='technical'; insight='5-minute backup power minimum for controlled descent'; action='Size emergency battery for 5-minute hover'; priority='high'}
)

$llCount = 0
foreach ($ll in $lessons) {
    $llData = @{
        fields = @{
            'Title' = $ll.title
            'Category' = $ll.category
            'Insight' = $ll.insight
            'Action' = $ll.action
            'Priority' = $ll.priority
            'Applicability' = 'Tethered drone systems'
        }
    } | ConvertTo-Json -Depth 5

    try {
        $result = Invoke-RestMethod -Uri "$baseUrl/RE_Lessons_Learned" -Method Post -Headers $headers -Body $llData
        $llCount++
        Write-Host "  Created: $($ll.title)" -ForegroundColor Green
    } catch {
        Write-Host "  Error creating $($ll.title): $_" -ForegroundColor Red
    }
}
Write-Host "  Total lessons synced: $llCount" -ForegroundColor Cyan

# Summary
Write-Host "`n=== Sync Complete ===" -ForegroundColor Cyan
Write-Host "Project: TOD-2025-001 (Tethered Observation Drone)"
Write-Host "Components: $componentCount"
Write-Host "Functions: $functionCount"
Write-Host "Working Principles: $wpCount"
Write-Host "Lessons Learned: $llCount"
