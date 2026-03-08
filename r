#Requires -RunAsAdministrator

# --- A2K REFORGE™ : CONFIGURATION ---
$Version = "2026.8"
$RepoUser = "mamc0826"
$RepoName = "a2k-lat-site"
$RepoBranch = "main" 
$RemoteScriptUrl = "https://raw.githubusercontent.com/$RepoUser/$RepoName/$RepoBranch/reforge.ps1"
$RawBaseUrl = "https://raw.githubusercontent.com/$RepoUser/$RepoName/$RepoBranch/assets/wallpapers"
$LocalWallDir = "$env:USERPROFILE\Desktop\A2K_Wallpapers"
$PortalUrl = "https://a2k.lat"

# --- AUDIO PROTOCOLS ---
function Play-Startup {
    for ($i = 3; $i -gt 0; $i--) { [console]::beep(400 + ($i * 100), 100); Start-Sleep -Seconds 1 }
    [console]::beep(880, 100); [console]::beep(1108, 100); [console]::beep(1318, 300)
}
function Play-Success { [console]::beep(880, 150); [console]::beep(1108, 150); [console]::beep(1318, 400) }

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
            if ($matches[1] -gt $Version) {
                [console]::beep(1000, 200); [console]::beep(1200, 200)
                if ((Read-Host "Update? (Y/N)") -eq "Y") {
                    $RemoteContent.Content | Out-File -FilePath $MyInvocation.MyCommand.Definition -Force
                    exit
                }
            }
        }
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
        Write-Host "[1] REFORGE COMPLETO" -ForegroundColor Yellow
        Write-Host "[2] VISUALES" -ForegroundColor Cyan
        Write-Host "[3] RENDIMIENTO" -ForegroundColor Green
        Write-Host "[4] MODO GAMING" -ForegroundColor Blue
        Write-Host "[5] LIMPIEZA BLOATWARE (Deep Purge)" -ForegroundColor Red
        Write-Host "[6] PRIVACIDAD" -ForegroundColor Magenta
        Write-Host "[7] ARSENAL A2K" -ForegroundColor Green
        Write-Host "[33] ACTIVAR WINDOWS" -ForegroundColor White
        Write-Host "[W] Visitar A2K.LAT" -ForegroundColor Cyan
        Write-Host "[Q] Salir" -ForegroundColor Red
    } else {
        Write-Host "[1] FULL REFORGE" -ForegroundColor Yellow
        Write-Host "[2] VISUALS" -ForegroundColor Cyan
        Write-Host "[3] PERFORMANCE" -ForegroundColor Green
        Write-Host "[4] GAMING MODE" -ForegroundColor Blue
        Write-Host "[5] BLOAT PURGE (Deep Purge)" -ForegroundColor Red
        Write-Host "[6] PRIVACY" -ForegroundColor Magenta
        Write-Host "[7] A2K ARSENAL" -ForegroundColor Green
        Write-Host "[33] ACTIVATE WINDOWS" -ForegroundColor White
        Write-Host "[W] Visit A2K.LAT" -ForegroundColor Cyan
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
        # Syncing Cloud Wallpaper
        $wallpapers = @("wall1.jpg", "wall2.jpg", "wall3.jpg")
        $selected = $wallpapers | Get-Random
        if (!(Test-Path $LocalWallDir)) { New-Item -Path $LocalWallDir -ItemType Directory -Force | Out-Null }
        try {
            Invoke-WebRequest -Uri "$RawBaseUrl/$selected" -OutFile "$LocalWallDir\$selected" -ErrorAction SilentlyContinue
            $code = 'using System.Runtime.InteropServices; public class Wallpaper { [DllImport("user32.dll", CharSet = CharSet.Auto)] public static extern int SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni); }'
            Add-Type -TypeDefinition $code -ErrorAction SilentlyContinue
            [Wallpaper]::SystemParametersInfo(20, 0, "$LocalWallDir\$selected", 3)
        } catch { }
    }

    if ($choice -match "1|5") {
        $purgeList = @(
            "Microsoft.OneDrive", "LinkedIn", "YourPhone", "Clipchamp", 
            "Outlook", "Xbox", "Solitaire", "Skype", "Groove", 
            "OneNote", "Teams", "Cortana", "TikTok", "Disney"
        )
        $results = @()
        
        Write-Host ">> Deep Purging Bloatware..." -ForegroundColor Red
        foreach ($app in $purgeList) {
            $status = if($isSp){ "Eliminando" } else { "Removing" }
            Write-Progress -Activity "A2K Purge" -Status "$status: $app"
            try {
                # Remove from current user AND all users
                Get-AppxPackage -Name "*$app*" -AllUsers | Remove-AppxPackage -ErrorAction Stop
                $results += "[PASS] $app"
            } catch {
                $results += "[FAIL] $app (Not Found/In Use)"
            }
        }
        
        # Deep OneDrive Removal Logic
        taskkill /f /im OneDrive.exe -ErrorAction SilentlyContinue
        $oneDrivePath = "$env:SystemRoot\SysWOW64\OneDriveSetup.exe"
        if (!(Test-Path $oneDrivePath)) { $oneDrivePath = "$env:SystemRoot\System32\OneDriveSetup.exe" }
        if (Test-Path $oneDrivePath) { Start-Process $oneDrivePath "/uninstall" -NoNewWindow -Wait }
        Set-A2KRegistry "HKLM:\SOFTWARE\Policies\Microsoft\Windows\OneDrive" "DisableFileSyncNGSC" 1

        # Summary Report
        Show-Header
        Write-Host "--- PURGE SUMMARY ---" -ForegroundColor Yellow
        $results | ForEach-Object { 
            if($_ -match "PASS"){ Write-Host $_ -ForegroundColor Green } else { Write-Host $_ -ForegroundColor Gray }
        }
        pause
    }

    if ($choice -match "1|7") {
        $appMap = @{"1"="Google.Chrome"; "2"="Google.ChromeRemoteDesktop"; "3"="Brave.Brave"; "4"="7zip.7zip"; "5"="Malwarebytes.Malwarebytes"; "6"="RevoUninstaller.RevoUninstaller"; "7"="AntibodySoftware.WizTree"}
        Show-Header
        Write-Host " [1-7] Select apps (e.g., 1 4) or 'ALL':" -ForegroundColor Green
        $userApps = Read-Host "A2K"
        $toInstall = if ($userApps -eq "ALL") { $appMap.Values } else { $userApps.Split(" ") | ForEach-Object { if($appMap[$_]){$appMap[$_]} } }
        
        # Stability Fix: Install one by one with a small delay
        foreach ($app in $toInstall) {
            if ($app) {
                Write-Host ">> Deploying $app..." -ForegroundColor Cyan
                winget install --id $app --silent --accept-package-agreements --accept-source-agreements
                Start-Sleep -Seconds 2 # Prevents Winget database locking
            }
        }
    }

    if ($choice -eq "W" -or $choice -eq "w") { Start-Process $PortalUrl }
    if ($choice -eq "33") { irm https://get.activated.win | iex }
    if ($choice -eq "Q" -or $choice -eq "q") { exit }
    if ($choice -match "1|2|3|4|5") { Stop-Process -Name explorer -Force -ErrorAction SilentlyContinue }
    Play-Success
    pause
}
