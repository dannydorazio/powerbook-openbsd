# PowerBook OpenBSD Setup

A collection of tools, scripts, and configurations for running OpenBSD on 32-bit PowerPC Macs (macppc).

**Primary target:** PowerBook G4 12" running OpenBSD 7.7  
**Status:** Your mileage may vary on other PowerPC Macs - contributions welcome!

## 🎯 Project Goals

This repository aims to make it easier to use OpenBSD on vintage PowerPC Macs by providing:
- Essential system packages curated for PowerPC
- Custom tools built specifically for OpenBSD/macppc
- Installation scripts for third-party tools
- Dotfiles and configurations optimized for the platform

## 📦 What's Included

### System Packages (from OpenBSD ports)
Installed via `packages.txt`:
- **Development:** git, cmake, gmake, gnupg
- **Editors:** vim, nano
- **Shells:** bash
- **Utilities:** htop, tmux, wget, curl
- **Window Manager:** windowmaker (NeXTStep-style)

**Note:** Full desktop environments like XFCE, MATE, and GNOME are not available on OpenBSD macppc (32-bit PowerPC). Window Maker and CWM (default) are the recommended lightweight options.

### Third-Party Tools (compiled from source)
- **fastfetch** - System information display tool
- **pyenv** - Python version management

### Custom Tools (built for this project)
- **wifi-manager** - WiFi network management for OpenBSD ([docs](tools/wifi-manager/README.md))
- **cwm-config** - CWM window manager configuration with keybindings and colors ([docs](tools/cwm-config/README.md))

### Web Browsers
- **Dillo** - Ultra-lightweight browser, no JavaScript
- **NetSurf** - Lightweight browser with better rendering than Dillo

**Note**: Modern browsers (Firefox, Chromium) are NOT available on macppc. Dillo and NetSurf are suitable for basic web browsing, documentation reading, and simple sites.

## 🚀 Quick Start

```bash
# Clone the repository
git clone git@github.com:dannydorazio/powerbook-openbsd.git
cd powerbook-openbsd

# Run the installer
./install.sh
```

The installer will show you available components:
```
1) fastfetch   - System information tool (built from source)
2) packages    - Install essential system packages from packages.txt  
3) pyenv       - Python version management tool
4) wifi-manager - WiFi network management tool for OpenBSD
```

Press Enter to install everything, or enter numbers (e.g., `1 3`) to install specific tools.

## 🖥️ System Info

**Tested Configuration:**
- **Model:** PowerBook G4 12" (PowerBook6,4)
- **CPU:** PowerPC 7447A @ 1.33 GHz
- **GPU:** NVIDIA GeForce FX Go 5200
- **RAM:** 1.25 GiB
- **OS:** OpenBSD 7.7 macppc
- **WiFi:** Broadcom bwi0

## 📁 Repository Structure

```
powerbook-openbsd/
├── README.md              # This file
├── packages.txt           # List of pkg packages to install
├── install.sh             # Master installer script
├── installers/            # Individual installer scripts
│   ├── fastfetch-installer.sh
│   ├── packages-installer.sh
│   ├── pyenv-installer.sh
│   └── wifi-manager-installer.sh
└── tools/                 # Custom tools
    └── wifi-manager/      # WiFi management tool
        ├── README.md
        └── wifi-manager
```

## 🛠️ Adding New Tools

### Adding a Custom Tool

1. Create a directory in `tools/your-tool/`
2. Add your script/binary and README.md
3. Create `installers/your-tool-installer.sh`:

```sh
#!/bin/sh
# INSTALLER_NAME: your-tool
# INSTALLER_DESC: Brief description of what it does
# INSTALLER_VERSION: 1.0

# Installation code here
cp tools/your-tool/your-tool /usr/local/bin/
chmod +x /usr/local/bin/your-tool
```

The master installer will automatically discover and list it!

### Adding System Packages

Just add the package name to `packages.txt` (one per line, comments start with `#`).

## 🔐 Commit Signing

All commits from this repository are GPG signed for verification.

## 🤝 Contributing

This is primarily built for my PowerBook G4 12", but I'd love to make it work on other PowerPC Macs:
- PowerBook G4 15"/17"
- iBook G3/G4
- Power Mac G4/G5
- iMac G3/G4/G5

If you test on other hardware, please open an issue or PR with your findings!

## 📝 License

MIT License - Feel free to use and modify

## 🙏 Acknowledgments

Built with assistance from Claude Code on a journey to breathe new life into vintage PowerPC hardware.
