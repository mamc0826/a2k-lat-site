#Requires -RunAsAdministrator

# --- A2K REFORGE™ : PERFORMANCE PROTOCOL ---
$Host.UI.RawUI.WindowTitle = "A2K REFORGE™ | ELITE PERFORMANCE"
$WallpaperUrl = "https://raw.githubusercontent.com/mamc0826/a2k-site/master/assets/images/wall1.jpg"
$WallpaperPath = "$env:USERPROFILE\Pictures\reforge_wallpaper.jpg"
$WebUrl = "https://a2k.lat/frp"

# --- REGISTRY ENGINE ---
function Set-A2KRegistry {
    param ([string]$Path, [string]$Name, $Value, [string]$Type = "DWORD")
    if (!(Test-Path $Path)) { New-Item -Path $Path -Force | Out-Null }
    Set-ItemProperty -Path $Path -Name $Name -Value $Value -Type $Type -ErrorAction SilentlyContinue
}

# --- LANGUAGE SELECTION ---
Clear-Host
Write-Host " [1] English"
Write-Host " [2] Español"
$langChoice = Read-Host " Select Language / Seleccione Idioma"
$isSp = ($langChoice -eq "2")

function Play-Startup {
    Write-Host "`n $(if($isSp){'INICIALIZANDO...'}else{'INITIALIZING...'})" -ForegroundColor Gray
    for ($i = 3; $i -gt 0; $i--) {
        [console]::beep(400 + ($i * 100), 100); Start-Sleep -Seconds 1
    }
    [console]::beep(880, 100); [console]::beep(1318, 300)
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
    Write-Host " ========================== ELITE PERFORMANCE v2026.1 ==========================" -ForegroundColor White -BackgroundColor Blue
    $OS = Get-CimInstance Win32_OperatingSystem
    Write-Host " [ MATEHUALA REPAIR SHOP ] - CPU: $((Get-CimInstance Win32_Processor).Name)" -ForegroundColor Gray
    Write-Host "----------------------------------------------------------------------------------" -ForegroundColor Cyan
}

Play-Startup
while($true) {
    Show-Header
    Write-Host "[1] FULL SYSTEM REFORGE (Performance + Visuals + Bloat)" -ForegroundColor Yellow
    Write-Host "[2] VISUAL OVERHAUL (Dark Mode, Wallpaper, Classic Menu)" -ForegroundColor Cyan
    Write-Host "[3] PERFORMANCE BOOST (Kill Transparency & Animations)" -ForegroundColor Green
    Write-Host "[4] BLOATWARE PURGE (Uninstall Junk Apps)" -ForegroundColor Red
    Write-Host "[5] AI & PRIVACY SHIELD (Kill Copilot, Recall, Telemetry)" -ForegroundColor Magenta
    Write-Host "[6] POWER USER TWEAKS (Mouse, Sticky Keys, Network)" -ForegroundColor White
    Write-Host "[7] INSTALL A2K ARSENAL (Chrome, Remote Desktop, Tools)" -ForegroundColor Green
    Write-Host "[W] Visit A2K Portal" -ForegroundColor Cyan
    Write-Host "[Q] Exit" -ForegroundColor Red
    Write-Host ""
    
    $choice = Read-Host "A2K_SYSTEM_COMMAND"

    # --- MODULE 2: VISUALS ---
    if ($choice -match "1|2") {
        Write-Host ">> Applying Visuals..." -ForegroundColor Cyan
        Set-A2KRegistry "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" "AppsUseLightTheme" 0
        Set-A2KRegistry "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" "SystemUsesLightTheme" 0
        Set-A2KRegistry "HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" "(Default)" "" "String"
        # Wallpaper
        Invoke-WebRequest -Uri $WallpaperUrl -OutFile $WallpaperPath -ErrorAction SilentlyContinue
        $code = 'using System.Runtime.InteropServices; public class Wallpaper { [DllImport("user32.dll", CharSet = CharSet.Auto)] public static extern int SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni); }'
        Add-Type -TypeDefinition $code -ErrorAction SilentlyContinue
        [Wallpaper]::SystemParametersInfo(20, 0, $WallpaperPath, 3)
    }

    # --- MODULE 3: PERFORMANCE (Transparency & Animations) ---
    if ($choice -match "1|3") {
        Write-Host ">> Killing Transparency & Animations..." -ForegroundColor Green
        Set-A2KRegistry "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" "EnableTransparency" 0
        Set-A2KRegistry "HKCU:\Control Panel\Desktop" "UserPreferencesMask" ([byte[]](0x90,0x12,0x03,0x80,0x10,0x00,0x00,0x00)) "Binary"
        Set-A2KRegistry "HKCU:\Control Panel\Desktop\WindowMetrics" "MinAnimate" 0
        Set-A2KRegistry "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" "VisualFXSetting" 2
    }

    # --- MODULE 4: BLOATWARE PURGE ---
    if ($choice -match "1|4") {
        Write-Host ">> Purging System Bloat..." -ForegroundColor Red
        $bloat = @("*TikTok*", "*Disney*", "*News*", "*Weather*", "*Solitaire*", "*Spotify*", "*Office.OneNote*", "*Skype*", "*Teams*")
        foreach ($app in $bloat) { Get-AppxPackage -Name $app | Remove-AppxPackage -ErrorAction SilentlyContinue }
    }

    # --- MODULE 5 & 6: PRIVACY & POWER ---
    if ($choice -match "1|5") {
        Set-A2KRegistry "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsAI" "AllowRecallEnablement" 0
        Set-A2KRegistry "HKCU:\Software\Policies\Microsoft\Windows\WindowsCopilot" "TurnOffWindowsCopilot" 1
    }
    if ($choice -match "1|6") {
        Set-ItemProperty -Path "HKCU:\Control Panel\Mouse" -Name "MouseSpeed" -Value 0
        Set-ItemProperty -Path "HKCU:\Control Panel\Accessibility\StickyKeys" -Name "Flags" -Value 506
        powercfg /hibernate off
    }

    # --- MODULE 7: ARSENAL ---
    if ($choice -match "1|7") {
        $apps = @("Google.Chrome", "Google.ChromeRemoteDesktop", "Brave.Brave", "7zip.7zip", "Malwarebytes.Malwarebytes", "RevoUninstaller.RevoUninstaller", "AntibodySoftware.WizTree")
        for ($i=0; $i -lt $apps.Count; $i++) {
            Write-Progress -Activity "Deploying Arsenal" -Status "Installing $($apps[$i])" -PercentComplete (($i+1)/$apps.Count*100)
            winget install --id $($apps[$i]) --silent --accept-package-agreements --accept-source-agreements | Out-Null
        }
    }

    if ($choice -eq "W") { Start-Process $WebUrl }
    if ($choice -eq "Q") { exit }

    if ($choice -match "1|2|3|4") { Stop-Process -Name explorer -Force -ErrorAction SilentlyContinue }

    Write-Host "`nReforge Complete. Press any key..."
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
}
