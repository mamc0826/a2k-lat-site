#Requires -RunAsAdministrator

# --- A2K REFORGE™ : CONFIGURATION ---
$Version = "2026.5"
$RepoUser = "mamc0826"
$RepoName = "a2k-lat-site"
$RepoBranch = "main" 
$RemoteScriptUrl = "https://raw.githubusercontent.com/$RepoUser/$RepoName/$RepoBranch/reforge.ps1"
$RawBaseUrl = "https://raw.githubusercontent.com/$RepoUser/$RepoName/$RepoBranch/assets/wallpapers"
$LocalWallDir = "$env:USERPROFILE\Desktop\A2K_Wallpapers"

# --- AUDIO PROTOCOLS ---
function Play-Startup {
    for ($i = 3; $i -gt 0; $i--) { [console]::beep(400 + ($i * 100), 100); Start-Sleep -Seconds 1 }
    [console]::beep(880, 100); [console]::beep(1108, 100); [console]::beep(1318, 300)
}

function Play-Success {
    [console]::beep(880, 150); [console]::beep(1108, 150); [console]::beep(1318, 400)
}

# --- REGISTRY ENGINE ---
function Set-A2KRegistry {
    param ([string]$Path, [string]$Name, $Value, [string]$Type = "DWORD")
    if (!(Test-Path $Path)) { New-Item -Path $Path -Force | Out-Null }
    Set-ItemProperty -Path $Path -Name $Name -Value $Value -Type $Type -ErrorAction SilentlyContinue
}

# --- LANGUAGE INITIALIZATION ---
Clear-Host
Write-Host " [1] English" -ForegroundColor Cyan
Write-Host " [2] Español" -ForegroundColor Cyan
$langChoice = Read-Host " Select Language / Seleccione Idioma"
$isSp = ($langChoice -eq "2")

# --- AUTO-UPDATE ENGINE ---
function Check-ForUpdates {
    $msg = if($isSp){ ">> Buscando actualizaciones..." } else { ">> Checking for protocol updates..." }
    Write-Host $msg -ForegroundColor Gray
    try {
        $RemoteContent = Invoke-WebRequest -Uri $RemoteScriptUrl -UseBasicParsing -ErrorAction SilentlyContinue
        if ($RemoteContent.Content -match '\$Version\s*=\s*"([^"]+)"') {
            $RemoteVersion = $matches[1]
            if ($RemoteVersion -gt $Version) {
                [console]::beep(1000, 200); [console]::beep(1200, 200)
                $upMsg = if($isSp){ " [!] NUEVA VERSION: v$RemoteVersion. Actualizar? (Y/N)" } else { " [!] NEW VERSION: v$RemoteVersion. Update now? (Y/N)" }
                $UpdateChoice = Read-Host $upMsg
                if ($UpdateChoice -eq "Y") {
                    $Path = $MyInvocation.MyCommand.Definition
                    $RemoteContent.Content | Out-File -FilePath $Path -Force
                    exit
                }
            }
        }
    } catch { }
}

# --- CLOUD ASSET SYNC ---
function Set-A2KCloudWallpaper {
    $msg = if($isSp){ ">> Sincronizando Fondo de Pantalla..." } else { ">> Syncing Cloud Wallpaper..." }
    Write-Host $msg -ForegroundColor Cyan
    $wallpapers = @("wall1.jpg", "wall2.jpg", "wall3.jpg")
    $selected = $wallpapers | Get-Random
    $localPath = "$LocalWallDir\$selected"
    if (!(Test-Path $LocalWallDir)) { New-Item -Path $LocalWallDir -ItemType Directory -Force | Out-Null }
    try {
        Invoke-WebRequest -Uri "$RawBaseUrl/$selected" -OutFile $localPath -ErrorAction Stop
        $code = 'using System.Runtime.InteropServices; public class Wallpaper { [DllImport("user32.dll", CharSet = CharSet.Auto)] public static extern int SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni); }'
        Add-Type -TypeDefinition $code -ErrorAction SilentlyContinue
        [Wallpaper]::SystemParametersInfo(20, 0, $localPath, 3)
    } catch { }
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
    $title = if($isSp){ " ====================== RENDIMIENTO ELITE v$Version ======================" } else { " ========================== ELITE PERFORMANCE v$Version ==========================" }
    Write-Host $title -ForegroundColor White -BackgroundColor Blue
}

# --- STARTUP ---
Check-ForUpdates
Play-Startup

while($true) {
    Show-Header
    if($isSp) {
        Write-Host "[1] REFORGE COMPLETO (Todo)" -ForegroundColor Yellow
        Write-Host "[2] VISUALES (Tema Oscuro, Fondo Cloud, Menu Clasico)" -ForegroundColor Cyan
        Write-Host "[3] RENDIMIENTO (Sin Animaciones, Settings Avanzados)" -ForegroundColor Green
        Write-Host "[4] MODO GAMING (GPU, Latencia, GameDVR)" -ForegroundColor Blue
        Write-Host "[5] LIMPIEZA BLOATWARE (OneDrive, Xbox, Apps Junk)" -ForegroundColor Red
        Write-Host "[6] PRIVACIDAD (Sin AI Recall, Copilot, Telemetria)" -ForegroundColor Magenta
        Write-Host "[7] ARSENAL A2K (Herramientas de Reparacion)" -ForegroundColor Green
        Write-Host "[33] ACTIVAR WINDOWS (MAS)" -ForegroundColor White
        Write-Host "[Q] Salir" -ForegroundColor Red
    } else {
        Write-Host "[1] FULL REFORGE (All-in-One)" -ForegroundColor Yellow
        Write-Host "[2] VISUALS (Dark Mode, Cloud Wall, Classic Menu)" -ForegroundColor Cyan
        Write-Host "[3] PERFORMANCE (No Animations, Advanced System Settings)" -ForegroundColor Green
        Write-Host "[4] GAMING MODE (GPU, Latency, GameDVR)" -ForegroundColor Blue
        Write-Host "[5] BLOAT PURGE (OneDrive, Xbox, Junk Apps)" -ForegroundColor Red
        Write-Host "[6] PRIVACY (No AI Recall, Copilot, Telemetry)" -ForegroundColor Magenta
        Write-Host "[7] A2K ARSENAL (Repair Tools)" -ForegroundColor Green
        Write-Host "[33] ACTIVATE WINDOWS (MAS)" -ForegroundColor White
        Write-Host "[Q] Exit" -ForegroundColor Red
    }
    
    $choice = Read-Host "A2K"

    if ($choice -match "1|2") {
        Set-A2KRegistry "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" "AppsUseLightTheme" 0
        Set-A2KRegistry "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" "SystemUsesLightTheme" 0
        Set-A2KRegistry "HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" "(Default)" "" "String"
        Set-A2KRegistry "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" "SearchboxTaskbarMode" 0
        Set-A2KRegistry "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "ShowTaskViewButton" 0
        Set-A2KRegistry "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "TaskbarDa" 0
        Set-A2KCloudWallpaper
    }
    if ($choice -match "1|3") {
        # Advanced System Settings: Adjust for Best Performance
        Set-A2KRegistry "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" "VisualFXSetting" 2
        Set-A2KRegistry "HKCU:\Control Panel\Desktop" "UserPreferencesMask" ([byte[]](0x90,0x12,0x03,0x80,0x10,0x00,0x00,0x00)) "Binary"
        Set-A2KRegistry "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" "EnableTransparency" 0
        Set-ItemProperty -Path "HKCU:\Control Panel\Mouse" -Name "MouseSpeed" -Value 0
        powercfg /hibernate off
    }
    if ($choice -match "1|4") {
        Set-A2KRegistry "HKCU:\Software\Microsoft\Windows\CurrentVersion\GameDVR" "AppCaptureEnabled" 0
        Set-A2KRegistry "HKLM:\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" "HwSchMode" 2
        Set-A2KRegistry "HKLM:\SYSTEM\CurrentControlSet\Control\Power\PowerThrottling" "PowerThrottlingOff" 1
    }
    if ($choice -match "1|5") {
        $bloat = @("*Solitaire*", "*LinkedIn*", "*MicrosoftTodo*", "*Skype*", "*Xbox*", "*Groove*", "*Clipchamp*", "*OneNote*", "*Teams*", "*Cortana*", "*TikTok*", "*Disney*", "*Weather*")
        foreach ($app in $bloat) { Get-AppxPackage -AllUsers -Name $app | Remove-AppxPackage -ErrorAction SilentlyContinue }
        taskkill /f /im OneDrive.exe -ErrorAction SilentlyContinue
        Set-A2KRegistry "HKLM:\SOFTWARE\Policies\Microsoft\Windows\OneDrive" "DisableFileSyncNGSC" 1
    }
    if ($choice -match "1|6") {
        Set-A2KRegistry "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsAI" "AllowRecallEnablement" 0
        Set-A2KRegistry "HKCU:\Software\Policies\Microsoft\Windows\WindowsCopilot" "TurnOffWindowsCopilot" 1
    }
    if ($choice -match "1|7") {
        $apps = @("Google.Chrome", "Google.ChromeRemoteDesktop", "Brave.Brave", "7zip.7zip", "Malwarebytes.Malwarebytes", "RevoUninstaller.RevoUninstaller", "AntibodySoftware.WizTree")
        foreach ($app in $apps) { winget install --id $app --silent --accept-package-agreements --accept-source-agreements | Out-Null }
    }
    if ($choice -eq "33") { irm https://get.activated.win | iex }
    if ($choice -eq "Q" -or $choice -eq "q") { exit }
    
    if ($choice -match "1|2|3|4|5") { Stop-Process -Name explorer -Force -ErrorAction SilentlyContinue }
    Play-Success
    $doneMsg = if($isSp){ "Refuerzo Completado." } else { "Reforge Complete." }
    Write-Host "`n$doneMsg"
    pause
}
