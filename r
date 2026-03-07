#Requires -RunAsAdministrator

# --- A2K REFORGE™ : THE OMNI-PROTOCOL ---
$Host.UI.RawUI.WindowTitle = "A2K REFORGE™ | INITIALIZING..."
$WebUrl = "https://a2k.lat"

# --- REGISTRY ENGINE ---
function Set-A2KRegistry {
    param ([string]$Path, [string]$Name, $Value, [string]$Type = "DWORD")
    if (!(Test-Path $Path)) { New-Item -Path $Path -Force | Out-Null }
    Set-ItemProperty -Path $Path -Name $Name -Value $Value -Type $Type -ErrorAction SilentlyContinue
}

function Play-Startup {
    Write-Host "`n INITIALIZING SECURE LINK..." -ForegroundColor Gray
    for ($i = 3; $i -gt 0; $i--) {
        Write-Host " [REFORGE] Booting in $i... " -NoNewline -ForegroundColor Cyan
        [console]::beep(400 + ($i * 100), 100); Start-Sleep -Seconds 1; Write-Host "`r" -NoNewline
    }
    [console]::beep(880, 100); [console]::beep(1318, 300)
}

function Play-Success { [console]::beep(880, 150); [console]::beep(1318, 400) }

function Show-Header {
    Clear-Host
    Write-Host @"
    ___   ___  _  __  ____  _____  _____  ____  ____  _____ 
   / _ \ |__ \| |/ / |  _ \| ____||  ___|/ __ \|  _ \| ____|
  / /_\ \  ) |' /    | |_) |  _|  | |_  | |  | | |_) |  _|  
 / _   _ \/ / . \    |  _ <| |___ |  _| | |__| |  _ <| |___ 
/_/   \_\____|_|\_\   |_| \_\_____||_|    \____/|_| \_\_____|
"@ -ForegroundColor Cyan
    Write-Host " ========================== TOTAL SYSTEM RECAST v2026.1 ==========================" -ForegroundColor White -BackgroundColor Blue
    Write-Host " [ A2K TECH | MATEHUALA ] - STATUS: OPTIMIZATION MODULES ARMED" -ForegroundColor Gray
    Write-Host "----------------------------------------------------------------------------------" -ForegroundColor Cyan
}

# --- MAIN LOGIC ---
Play-Startup
while($true) {
    Show-Header
    Write-Host "[0] Create Restore Point" -ForegroundColor Green
    Write-Host "[1] Full System Recast (Customizable Options)" -ForegroundColor Yellow
    Write-Host "[2] Deep Maintenance & Updates" -ForegroundColor Yellow
    Write-Host "[3] Activation (MAS)" -ForegroundColor Yellow
    Write-Host "[Q] Exit" -ForegroundColor Red
    Write-Host ""
    $choice = Read-Host "A2K_COMMAND"

    switch ($choice) {
        "1" {
            Show-Header
            Write-Host "--- REFORGE PRE-FLIGHT BRIEFING ---" -ForegroundColor Cyan
            Write-Host "This module can perform the following:" -ForegroundColor Gray
            Write-Host " [A] UI Reforce (Classic Menus, End Task, Extensions)"
            Write-Host " [B] AI Shield (Kill Copilot & Recall)"
            Write-Host " [C] A2K Arsenal (Chrome, Brave, 7zip, Malwarebytes, etc.)"
            Write-Host " [ALL] Execute every optimization (Default)"
            Write-Host "-----------------------------------"
            $subChoice = Read-Host "Select Modules (e.g., AB or ALL)"
            if ($subChoice -eq "") { $subChoice = "ALL" }

            if ($subChoice -match "A|ALL") {
                Write-Host ">> Reforging UI..." -ForegroundColor Cyan
                Set-A2KRegistry "HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" "(Default)" "" "String"
                Set-A2KRegistry "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\TaskbarDeveloperSettings" "TaskbarEndTask" 1
                Stop-Process -Name explorer -Force -ErrorAction SilentlyContinue
            }
            if ($subChoice -match "B|ALL") {
                Write-Host ">> Engaging AI Shield..." -ForegroundColor Cyan
                Set-A2KRegistry "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsAI" "AllowRecallEnablement" 0
                Set-A2KRegistry "HKCU:\Software\Policies\Microsoft\Windows\WindowsCopilot" "TurnOffWindowsCopilot" 1
            }
            if ($subChoice -match "C|ALL") {
                Write-Host ">> Deploying A2K Arsenal..." -ForegroundColor Cyan
                $apps = @("Google.Chrome", "Brave.Brave", "7zip.7zip", "Malwarebytes.Malwarebytes", "RevoUninstaller.RevoUninstaller", "WizTree.WizTree", "VideoLAN.VLC", "Notepad++.Notepad++", "Python.Python.3")
                for ($i=0; $i -lt $apps.Count; $i++) {
                    $percent = [math]::Round((($i+1) / $apps.Count) * 100)
                    Write-Progress -Activity "Installing A2K Arsenal" -Status "Deploying $($apps[$i])" -PercentComplete $percent
                    winget install --id $($apps[$i]) --silent --accept-package-agreements --accept-source-agreements | Out-Null
                }
            }
            Play-Success
        }
        "2" {
            Show-Header
            Write-Host ">> Cleaning Temp Files..." -ForegroundColor Yellow
            Remove-Item -Path "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue
            Write-Host ">> Checking for Updates..." -ForegroundColor Cyan
            winget upgrade --all --silent
            Play-Success
        }
        "3" { irm https://get.activated.win | iex }
        "Q" { exit }
    }
    Write-Host "`nTask Complete. Press any key..."
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
}
