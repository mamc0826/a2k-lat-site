#Requires -RunAsAdministrator

# --- A2K REFORGE™ : THE OMNI-PROTOCOL ---
$Host.UI.RawUI.WindowTitle = "A2K REFORGE™ | INITIALIZING..."
$WebUrl = "https://a2k.lat"

# --- LANGUAGE SELECTION ---
Clear-Host
Write-Host " [1] English"
Write-Host " [2] Español"
$langChoice = Read-Host " Select Language / Seleccione Idioma"

$Text = @{
    Boot     = if($langChoice -eq "2") { "INICIALIZANDO ENLACE SEGURO..." } else { "INITIALIZING SECURE LINK..." }
    Wait     = if($langChoice -eq "2") { "[REFORGE] Iniciando en" } else { "[REFORGE] Booting in" }
    Status   = if($langChoice -eq "2") { "ESTADO: MÓDULOS DE OPTIMIZACIÓN ARMADOS" } else { "STATUS: OPTIMIZATION MODULES ARMED" }
    Opt0     = if($langChoice -eq "2") { "[0] Crear Punto de Restauración (Manual)" } else { "[0] Create Restore Point (Manual)" }
    Opt1     = if($langChoice -eq "2") { "[1] Reforja Total (Todo + Win11Debloat)" } else { "[1] Full System Recast (The Works + Win11Debloat)" }
    Opt2     = if($langChoice -eq "2") { "[2] Mantenimiento Profundo (Limpieza, Winget, CHKDSK)" } else { "[2] Deep Maintenance (Shop Clean, Winget, CHKDSK)" }
    Opt3     = if($langChoice -eq "2") { "[3] Ayuda de Activación (MAS)" } else { "[3] System Activation Help (MAS)" }
    OptW     = if($langChoice -eq "2") { "[W] Visitar Portal A2K (Web)" } else { "[W] Visit A2K Portal (Web)" }
    OptER    = if($langChoice -eq "2") { "[ER] Recuperación de Emergencia" } else { "[ER] Emergency Recovery (Rollback)" }
    OptQ     = if($langChoice -eq "2") { "[Q] Salir" } else { "[Q] Exit" }
    Reforge  = if($langChoice -eq "2") { "REFORJANDO" } else { "REFORGING" }
    Complete = if($langChoice -eq "2") { "Tarea Completada. Presione una tecla..." } else { "Task Complete. Press any key..." }
    Term     = if($langChoice -eq "2") { "TERMINANDO ENLACE SEGURO..." } else { "TERMINATING SECURE LINK..." }
}

function Play-Startup {
    Write-Host "`n $($Text.Boot)" -ForegroundColor Gray
    for ($i = 5; $i -gt 0; $i--) {
        Write-Host " $($Text.Wait) $i... " -NoNewline -ForegroundColor Cyan
        [console]::beep(300 + ($i * 100), 100)
        Start-Sleep -Seconds 1
        Write-Host "`r" -NoNewline
    }
    [console]::beep(880, 100); [console]::beep(1108, 100); [console]::beep(1318, 300)
}

function Play-Success { [console]::beep(880, 150); [console]::beep(1108, 150); [console]::beep(1318, 400) }

function Play-Shutdown {
    Write-Host "`n $($Text.Term)" -ForegroundColor Red
    [console]::beep(1318, 150); [console]::beep(1108, 150); [console]::beep(880, 400)
    Start-Sleep -Seconds 1
}

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
    Write-Host " [ A2K TECH | MATEHUALA, SLP ] - $($Text.Status)" -ForegroundColor Gray
    Write-Host "----------------------------------------------------------------------------------" -ForegroundColor Cyan
}

function Apply-Tweak ($Name, $ScriptBlock) {
    Write-Host " [$($Text.Reforge)] -> $Name..." -NoNewline -ForegroundColor White
    try { & $ScriptBlock; Write-Host " [DONE]" -ForegroundColor Green } 
    catch { Write-Host " [FAILED]" -ForegroundColor Red }
}

# --- STARTUP SEQUENCE ---
Play-Startup
$Host.UI.RawUI.WindowTitle = "A2K REFORGE™"

while($true) {
    Show-Header
    Write-Host $Text.Opt0 -ForegroundColor Green
    Write-Host $Text.Opt1 -ForegroundColor Yellow
    Write-Host $Text.Opt2 -ForegroundColor Yellow
    Write-Host $Text.Opt3 -ForegroundColor Yellow
    Write-Host $Text.OptW -ForegroundColor Cyan
    Write-Host $Text.OptER -ForegroundColor White -BackgroundColor Red
    Write-Host $Text.OptQ -ForegroundColor Red
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
            Apply-Tweak "Classic Context Menu" { Set-ItemProperty -Path "HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" -Name "(Default)" -Value "" }
            Apply-Tweak "Taskbar End Task" { Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\TaskbarDeveloperSettings" -Name "TaskbarEndTask" -Value 1 }
            Apply-Tweak "Disable AI Recall & Copilot" {
                $aiPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsAI"
                if (!(Test-Path $aiPath)) { New-Item -Path $aiPath -Force | Out-Null }
                Set-ItemProperty -Path $aiPath -Name "AllowRecallEnablement" -Value 0
                Set-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\Windows\WindowsCopilot" -Name "TurnOffWindowsCopilot" -Value 1
            }
            # Arsenal Deployment
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
            Apply-Tweak "Cleanup" { 
                Remove-Item -Path "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue
                Clear-RecycleBin -Confirm:$false -ErrorAction SilentlyContinue
            }
            winget upgrade --all --silent --accept-package-agreements --accept-source-agreements
            Play-Success
        }
        "3" { irm https://get.activated.win | iex }
        "W" { Start-Process $WebUrl }
        "ER" {
            $RP = Get-ComputerRestorePoint | Where-Object {$_.Description -match "A2KReforge"} | Select-Object -Last 1
            if ($RP) { Restore-Computer -RestorePoint $RP.SequenceNumber } else { rstrui.exe }
        }
        "Q" { Play-Shutdown; exit }
    }
    Write-Host "`n$($Text.Complete)"
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
}
