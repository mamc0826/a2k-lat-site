# ⚡ AZTEK (a2k) Windows 11 Suite

The ultimate collection of deployment and maintenance scripts for Windows 11. Designed for speed, aesthetics, and total system control.

---

## 🚀 Quick Launch Commands

### 🛡️ [NEW] AZTEK Sentinel (Maintenance & Activation)
The technician's "Swiss Army Knife" for activation, DNS optimization, and emergency recovery.
```powershell
powershell -ExecutionPolicy Bypass -Command "irm a2k.lat/sentinel.ps1 | iex"
🛠️ Interactive Auto-Setup (Recommended)
PowerShell
irm a2k.lat/i.html | iex
🤖 Automatic Version (No prompts)
PowerShell
irm a2k.lat/a.html | iex
📖 AZTEK Sentinel: Feature Guide
This suite is designed for post-installation maintenance and specialized system tweaks.

🛡️ ER Mode (Emergency Restore)
Safety first. Before applying deep tweaks, Sentinel creates a system-native restore point.

How to use: Select [0] in the menu.

Why: If a tweak doesn't fit your hardware, this rolls back your registry and system settings to the exact state they were in before you ran the script.

👑 God Mode (Master Control)
Unlock the hidden administrative power of Windows.

How to use: Select [2] in the menu.

Why: Windows hides 70% of its settings. God Mode places a shortcut on your desktop containing all 200+ administrative tools in one searchable folder.

🔑 MAS Activation
Sentinel uses the latest get.activated.win protocols.

How to use: Select [7] in the menu.

Why: Instantly and permanently licenses Windows and Office without third-party "crack" files.

📋 Auto-Setup Versions
Interactive Menu Version - RUN EVERYTHING - Install all programs, remove bloatware, configure settings.
Quick Start - See summary, then confirm.

Custom Installation - Choose exactly what to install/configure.

Automatic Version
No menus or prompts. Perfect for "deploy and walk away" scenarios on fresh installs.

🎯 Auto-Setup Features (27+ Programs)
Browsers & Media
Google Chrome, Firefox, Brave.

PotPlayer, VLC, YouTube Music Desktop.

Utilities & Tools
7-Zip, BCUninstaller, Revo Uninstaller.

Notepad++, Rufus, WizTree, Sumatra PDF.

Python 3.14, Scrcpy, Android SDK.

Remote & Virtualization
Chrome Remote Desktop, VMware Workstation Pro.

⚙️ System Optimizations
Theme: Dark Mode Enabled.

Transparency: Disabled for performance.

Privacy: Telemetry and Cortana disabled.

Bloatware: Xbox, Teams, and Microsoft 365 Hub removed.

🔧 Customization & Troubleshooting
Script Won't Run?
Ensure you are running PowerShell as Administrator and run this command:

PowerShell
Set-ExecutionPolicy Bypass -Scope Process -Force
Manual Installation Required for:
Office Tool Plus - Visit Site

UI.Vision XModule - Visit Site

Universal ADB Driver - Visit Site

🔐 Security & Privacy
✅ Uses official Microsoft Winget package manager.

✅ No system files modified (Settings only).

✅ Disables telemetry and tracking.

✅ Fully visible source code.

🌐 Links
Official Site: a2k.lat

Repo Root: github.com/mamc0826/a2k-lat-site

Made with ❤️ by AZTEK tech
