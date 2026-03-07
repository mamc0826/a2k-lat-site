#Requires -RunAsAdministrator

# --- A2K REFORGE™ : THE OMNI-PROTOCOL ---
$Host.UI.RawUI.WindowTitle = "A2K REFORGE™ | INITIALIZING..."
$WebUrl = "https://a2k.lat"

function Play-Startup {
    Write-Host "`n INITIALIZING SECURE LINK..." -ForegroundColor Gray
    for ($i = 5; $i -gt 0; $i--) {
        Write-Host " [REFORGE] Booting in $i... " -NoNewline -ForegroundColor Cyan
        [console]::beep(300 + ($i * 100), 100)
        Start-Sleep -Seconds 1
        Write-Host "`r" -NoNewline
    }
    # Startup "Handshake"
    [console]::beep(880, 100); [console]::beep(1108, 100); [console]::beep(1318, 300)
}

function Play-Success {
    [console]::beep(880, 150); [console]::beep(1108, 150); [console]::beep(1318, 400)
}

function Play-Shutdown {
    Write-Host "`n TERMINATING SECURE LINK..." -ForegroundColor Red
    [console]::beep(1318, 150); [console]::beep(1108, 150); [console]::beep(880, 400)
    Start-Sleep -Seconds 1
}

function Show-Header {
    Clear-Host
    Write-Host @"
    
     █████╗ ██████╗ ██╗  ██╗    ██████╗ ███████╗███████╗ ██████╗ ██████╗  ██████╗ ███████╗
    ██╔══██╗╚════██╗██║ ██╔╝    ██╔══██╗██╔════╝██╔════╝██╔═══██╗██╔══██╗██╔════╝ ██╔════╝
    ███████║ █████╔╝█████╔╝     ██████╔╝█████╗  █████╗  ██║   ██║██████╔╝██║  ███╗█████╗  
    ██╔══██║██╔═══╝ ██╔═██╗     ██╔══██╗██╔══╝  ██╔══╝  ██║   ██║██╔══██╗██║   ██║██╔══╝  
    ██║  ██║███████╗██║  ██╗    ██║  ██║███████╗██║     ╚██████╔╝██║  ██║╚██████╔╝███████╗
    ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝    ╚═╝  ╚═╝╚══════╝╚═╝      ╚═════╝ ╚═╝  ╚═╝ ╚═════╝ ╚══════╝
    
"@ -ForegroundColor Cyan
    Write-Host " ========================== TOTAL SYSTEM RECAST v2026.1 ==========================" -ForegroundColor White -BackgroundColor Blue
    Write-Host " CPU: $((Get-CimInstance Win32_Processor).Name) | ORIGIN: MATEHUALA, SLP" -ForegroundColor Gray
    Write-Host "----------------------------------------------------------------------------------" -ForegroundColor Cyan
}

function Apply-Tweak ($Name, $ScriptBlock) {
    Write-Host " [REFORGING] -> $Name..." -NoNewline -ForegroundColor White
    try { & $ScriptBlock; Write-Host " [DONE]" -ForegroundColor Green } 
    catch { Write-Host " [FAILED]" -ForegroundColor Red }
}

# --- STARTUP SEQUENCE ---
Play-Startup
$Host.UI.RawUI.WindowTitle = "A2K REFORGE™ | SYSTEM OPTIMIZATION"

while($true) {
    Show-Header
    Write-Host "[0] Create Restore Point (Manual)" -ForegroundColor Green
    Write-Host "[1] Full System Recast (The Works + Win11Debloat)" -ForegroundColor Yellow
    Write-Host "[2] Deep Maintenance (Shop Clean, Winget, CHKDSK)" -ForegroundColor Yellow
    Write-Host "[3] System Activation Help (MAS)" -ForegroundColor Yellow
    Write-Host "[W] Visit A2K Portal (Web)" -ForegroundColor Cyan
    Write-Host "[ER] Emergency Recovery (Rollback)" -ForegroundColor White -BackgroundColor Red
    Write-Host "[Q] Exit" -ForegroundColor Red
    Write-Host ""
    
    $choice = Read-Host "A2K_SYSTEM_COMMAND"

    switch ($choice) {
        "0" {
            Show-Header
            Write-Host ">> INITIATING SAFETY NET..." -ForegroundColor Yellow
            Enable-ComputerRestore -Drive "C:\" -ErrorAction SilentlyContinue
            Checkpoint-Computer -Description "A2KReforge_Manual" -RestorePointType "MODIFY_SETTINGS"
            Play-Success
        }
        
        "1" {
            Show-Header
            Write-Host ">> DEB-LOATING & RE-TOOLING SYSTEM..." -ForegroundColor Cyan
            
            # SHELL & UI INTEGRATION
            Apply-Tweak "Classic Context Menu" { Set-ItemProperty -Path "HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" -Name "(Default)" -Value "" }
            Apply-Tweak "Taskbar End Task" { Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\TaskbarDeveloperSettings" -Name "TaskbarEndTask" -Value 1 }
            Apply-Tweak "Kill AI Recall & Copilot" {
                $aiPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsAI"
                if (!(Test-Path $aiPath)) { New-Item -Path $aiPath -Force | Out-Null }
                Set-ItemProperty -Path $aiPath -Name "AllowRecallEnablement" -Value 0
                Set-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\Windows\WindowsCopilot" -Name "TurnOffWindowsCopilot" -Value 1
            }

            # ARSENAL DEPLOYMENT
            Write-Host "`n>> DEPLOYING A2K ARSENAL..." -ForegroundColor Yellow
            $apps = @("Google.Chrome", "Brave.Brave", "7zip.7zip", "Malwarebytes.Malwarebytes", "RevoUninstaller.RevoUninstaller", "WizTree.WizTree", "VideoLAN.VLC", "Notepad++.Notepad++", "Python.Python.3")
            foreach ($app in $apps) {
                Write-Host "   Installing $app..." -NoNewline
                winget install --id $app --silent --accept-package-agreements --accept-source-agreements | Out-Null
                Write-Host " [OK]" -ForegroundColor Green
            }

            Stop-Process -Name explorer -Force -ErrorAction SilentlyContinue
            Play-Success
        }

        "2" {
            Show-Header
            Write-Host ">> RUNNING SHOP CLEANUP..." -ForegroundColor Cyan
            Apply-Tweak "Clearing Temp & Junk" { 
                Remove-Item -Path "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue
                Clear-RecycleBin -Confirm:$false -ErrorAction SilentlyContinue
            }
            winget upgrade --all --silent --accept-package-agreements --accept-source-agreements
            Play-Success
        }

        "3" {
            Show-Header
            Write-Host ">> LAUNCHING MAS..." -ForegroundColor Magenta
            irm https://get.activated.win | iex
        }

        "W" { Start-Process $WebUrl }

        "ER" {
            $RP = Get-ComputerRestorePoint | Where-Object {$_.Description -match "A2KReforge"} | Select-Object -Last 1
            if ($RP) { Restore-Computer -RestorePoint $RP.SequenceNumber } else { rstrui.exe }
        }

        "Q" { 
            Play-Shutdown
            exit 
        }
    }
    Write-Host "`nTask Complete. Press any key..."
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
}
