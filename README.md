# Windows 11 Auto-Setup Scripts

Two versions available: **Automatic** and **Interactive Menu**

---

## 🚀 Quick Start Commands

### Interactive Menu Version (Recommended)
```powershell
irm a2k.lat/i.html | iex
```

### Automatic Version (No prompts, runs everything)
```powershell
irm a2k.lat/a.html | iex
```

---

## 📋 What's the Difference?

### **Interactive Menu Version** 
- 3 options at startup:
  1. **RUN EVERYTHING** - Install all programs, remove bloatware, configure settings (one confirmation)
  2. **Quick Start with Confirmation** - See summary, then confirm or cancel
  3. **Custom Installation** - Choose exactly what to install/configure
- Perfect for when you want control

### **Automatic Version**
- No menus or prompts
- Runs everything automatically
- Perfect for completely fresh installs when you want it all

---

## 🎯 Features

### What Gets Installed (27+ Programs)

#### **Browsers**
- Google Chrome
- Mozilla Firefox
- Brave Browser

#### **Utilities & Tools**
- 7-Zip
- BCUninstaller
- Revo Uninstaller
- EarTrumpet
- MicMute
- Notepad++
- Rufus
- WizTree
- Sumatra PDF
- Grub2Win
- MiniTool Partition Wizard Free

#### **Media Players**
- PotPlayer
- VLC Media Player
- YouTube Music Desktop App
- HandBrake

#### **Development & Android Tools**
- Python 3.14
- Scrcpy (Android screen mirroring)
- Android SDK Platform Tools (ADB, fastboot)

#### **Remote Access & Virtualization**
- Chrome Remote Desktop
- VMware Workstation Pro (free version)

#### **Gaming**
- GGPoker

### Manual Installation Required
- **Office Tool Plus** - https://otp.landian.vip/
- **UI.Vision XModule** - https://ui.vision/
- **Simp Music** - https://github.com/Simp-Music/Simp-Music
- **SFWTool** - https://github.com/SFW-FreeDevelopment/SFWTool
- **Universal ADB Driver** - https://adb.clockworkmod.com/

---

## 🗑️ Bloatware Removed

- **Xbox Apps** - Gaming App, Xbox App, Xbox overlays
- **Games** - Solitaire Collection, Sticky Notes
- **Microsoft 365** - OneNote, Office Hub
- **Teams** - All Teams components

---

## ⚙️ Windows Settings Configured

| Setting | Change |
|---------|--------|
| Theme | Dark Mode enabled |
| Transparency | Disabled |
| Audio Scheme | Set to "No Sounds" |
| File Extensions | Shown |
| Hidden Files | Shown |
| Telemetry | Disabled |
| Cortana | Disabled |
| Taskbar Search | Icon only (not search box) |
| Taskbar People | Hidden |
| Default Browser | Chrome (requires manual confirmation) |

---

## 📖 Usage Instructions

### Option 1: One-Line Command (Recommended)

**Interactive Menu:**
```powershell
irm a2k.lat/i.html | iex
```

**Automatic (No Prompts):**
```powershell
irm a2k.lat/a.html | iex
```

### Option 2: Download and Run

1. Download the `.ps1` file
2. Right-click → "Run with PowerShell"
3. Click "Yes" for Administrator privileges

### Option 3: PowerShell Manual

```powershell
# Open PowerShell as Administrator
Set-ExecutionPolicy Bypass -Scope Process -Force
.\w11a2kint.ps1
```

---

## 🎨 Interactive Menu Example

When you run the interactive version, you'll see:

```
========================================
Windows 11 Auto-Setup Script
Interactive Menu Edition
========================================

Please choose an option:

  1. RUN EVERYTHING (Recommended - Install all, remove bloatware, configure settings)
  2. Quick Start with Confirmation (Review summary before proceeding)
  3. Custom Installation (Choose what to install/configure)
  4. Exit

Enter your choice (1-4):
```

### Menu Options Explained:

**Option 1: RUN EVERYTHING**
- Shows what will happen
- One Y/N confirmation
- Then runs everything automatically
- Fastest option if you want it all

**Option 2: Quick Start with Confirmation**
- Shows detailed summary of everything that will happen
- One Y/N to proceed or cancel
- Good balance of control and speed

**Option 3: Custom Installation**
- Choose to install software (Y/N)
- If yes, choose which categories:
  - Browsers
  - Utilities
  - Media
  - Development
  - Remote/Virtualization
  - Gaming
- Choose to remove bloatware (Y/N)
- Choose to configure settings (Y/N)
- Shows final summary
- One Y/N to proceed
- Maximum control

---

## ⏱️ Estimated Time

- **Full installation**: 20-40 minutes (depending on internet speed)
- **Custom installation**: 5-30 minutes (depending on selections)

---

## 🔧 Customization

### Adding More Programs

1. Find the winget ID:
   ```powershell
   winget search "program name"
   ```

2. Edit the script and add to appropriate category:
   ```powershell
   Browsers = @(
       @{Name="Opera"; ID="Opera.Opera"}
   )
   ```

### Adding More Bloatware to Remove

1. Find package name:
   ```powershell
   Get-AppxPackage | Select Name, PackageFullName
   ```

2. Add to `$bloatware` array in script

---

## 🐛 Troubleshooting

### Script Won't Run
```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force
```

### Some Programs Failed to Install
- Check internet connection
- Manually install: `winget install --id ProgramID`

### Settings Didn't Apply
- Restart your computer
- Some require sign out/sign in

### Chrome Not Default Browser
- Windows 11 requires manual confirmation
- Settings > Apps > Default apps > Chrome

---

## 📝 Post-Installation Checklist

- [ ] Restart computer
- [ ] Manually install remaining programs (Office Tool Plus, etc.)
- [ ] Set default browser in Windows Settings
- [ ] Verify all programs installed
- [ ] Check Windows settings applied correctly

---

## 🔐 Security & Privacy

This script:
- ✅ Uses official Microsoft winget package manager
- ✅ Only installs from verified sources
- ✅ Only modifies user settings (no system files)
- ✅ Fully visible source code (inspect before running)
- ✅ Disables telemetry and tracking
- ✅ All changes reversible

---

## 📦 Version History

- **v2.0** (2026-02-05) - Added interactive menu system
- **v1.0** (2026-02-05) - Initial automatic version

---

## 🌐 Links

- **GitHub Repository**: https://github.com/mamc0826/a2k-lat-site
- **Domain**: https://a2k.lat

---

## 💡 Pro Tips

1. **Run on fresh Windows install** for best results
2. **Use USB drive** if you don't have internet during setup
3. **Create multiple versions** for different use cases (gaming, dev, office)
4. **Keep a backup** of your customized script

---

## 📞 Support

Issues? Check the troubleshooting section or review the script source code.

**Made with ❤️ for faster Windows setups**
