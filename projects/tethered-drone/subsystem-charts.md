# Tethered Observation Drone - Subsystem Visualizations

## 1. Component Distribution by Subsystem

![Subsystem Component Count](https://quickchart.io/chart?c={type:'bar',data:{labels:['Propulsion','Flight%20Control','Payload','Power','Communications','Tether%20Mgmt','Ground%20Station'],datasets:[{label:'Components',data:[3,4,4,3,3,4,4],backgroundColor:['%23FF6384','%2336A2EB','%23FFCE56','%234BC0C0','%239966FF','%23FF9F40','%23C9CBCF']}]},options:{title:{display:true,text:'Components%20per%20Subsystem'},scales:{yAxes:[{ticks:{beginAtZero:true}}]}}})

## 2. Subsystem Type Distribution

![Subsystem Types](https://quickchart.io/chart?c={type:'doughnut',data:{labels:['Essential','Auxiliary'],datasets:[{data:[5,2],backgroundColor:['%234BC0C0','%23FF9F40']}]},options:{title:{display:true,text:'Essential%20vs%20Auxiliary%20Functions'}}})

## 3. Component Origin by Country

![Country of Origin](https://quickchart.io/chart?c={type:'pie',data:{labels:['Vietnam%20(Indigenous)','China','USA','Japan'],datasets:[{data:[4,4,2,1],backgroundColor:['%23FF6384','%23FFCE56','%2336A2EB','%234BC0C0']}]},options:{title:{display:true,text:'Component%20Country%20of%20Origin'}}})

## 4. COTS vs Custom Components

![COTS vs Custom](https://quickchart.io/chart?c={type:'pie',data:{labels:['COTS','Custom'],datasets:[{data:[6,4],backgroundColor:['%2336A2EB','%23FF6384']}]},options:{title:{display:true,text:'COTS%20vs%20Custom%20Components'}}})

## 5. Power Budget by Subsystem

![Power Distribution](https://quickchart.io/chart?c={type:'bar',data:{labels:['Propulsion','Gimbal','Flight%20Control','Communications','Sensors'],datasets:[{label:'Power%20(W)',data:[500,36,15,20,25],backgroundColor:'%234BC0C0'}]},options:{title:{display:true,text:'Estimated%20Power%20Consumption'},scales:{yAxes:[{ticks:{beginAtZero:true}}]}}})

## 6. System Architecture (Mermaid)

```mermaid
flowchart TB
    subgraph GS["Ground Station"]
        PSU["Power Supply\n48V/720W"]
        REEL["Tether Reel"]
        CONSOLE["Control Console"]
    end

    subgraph TETHER["Tether Assembly"]
        CABLE["Hybrid Cable\nPower+Fiber+Kevlar"]
    end

    subgraph AIRCRAFT["Aircraft Platform"]
        subgraph SS1["SS-01: Propulsion"]
            MOTORS["Motors ×4"]
            ESC["ESCs ×4"]
            PROPS["Propellers ×4"]
        end

        subgraph SS2["SS-02: Flight Control"]
            FC["Autopilot"]
            IMU["IMU ×3"]
            GPS["GPS"]
        end

        subgraph SS3["SS-03: Power"]
            DCDC["DC-DC\n48V→12V"]
            PDB["Power Board"]
            BATT["Backup Battery"]
        end

        subgraph SS4["SS-04: Payload"]
            GIMBAL["3-Axis Gimbal"]
            EO["EO Camera"]
            IR["IR Camera"]
        end

        subgraph SS5["SS-05: Comms"]
            FIBER["Fiber\nTransceiver"]
            ETH["Ethernet\nSwitch"]
        end

        SWIVEL["Swivel Joint"]
    end

    PSU -->|"48V DC"| CABLE
    CONSOLE -->|"Commands"| CABLE
    CABLE --> SWIVEL
    SWIVEL --> DCDC
    SWIVEL --> FIBER
    DCDC --> PDB
    PDB --> MOTORS
    PDB --> FC
    PDB --> GIMBAL
    FC --> ESC
    ESC --> MOTORS
    IMU --> FC
    GPS --> FC
    GIMBAL --> EO
    GIMBAL --> IR
    FIBER --> ETH
    ETH --> FC
    REEL --> CABLE
```

## 7. Function Hierarchy Radar

![Function Coverage](https://quickchart.io/chart?c={type:'radar',data:{labels:['Propulsion','Control','Power','Payload','Comms','Tether','Safety'],datasets:[{label:'Completeness%20%25',data:[95,90,85,90,88,92,80],backgroundColor:'rgba(54,162,235,0.2)',borderColor:'%2336A2EB'}]},options:{title:{display:true,text:'Subsystem%20Documentation%20Completeness'}}})

---

## Quick Reference Links

| Chart | Direct URL |
|-------|-----------|
| Component Count | [View](https://quickchart.io/chart?c={type:'bar',data:{labels:['Propulsion','Flight%20Control','Payload','Power','Communications','Tether','Ground'],datasets:[{label:'Components',data:[3,4,4,3,3,4,4],backgroundColor:'%234BC0C0'}]}}) |
| Power Budget | [View](https://quickchart.io/chart?c={type:'bar',data:{labels:['Propulsion','Gimbal','FC','Comms','Sensors'],datasets:[{label:'Watts',data:[500,36,15,20,25],backgroundColor:'%23FF6384'}]}}) |
| Country Origin | [View](https://quickchart.io/chart?c={type:'pie',data:{labels:['Vietnam','China','USA','Japan'],datasets:[{data:[4,4,2,1]}]}}) |

