# PowerBook G4 OpenBSD Setup

This repository contains configuration files and scripts for the PowerBook G4 running OpenBSD 7.7.

## System Info

- **Model**: PowerBook6,4
- **CPU**: PowerPC 7447A @ 1.33 GHz
- **GPU**: NVIDIA GeForce FX Go 5200
- **RAM**: 1.19 GiB
- **OS**: OpenBSD 7.7 macppc

## Scripts

### wifi-manager

A WiFi network management tool for OpenBSD.

**Installation:**
```bash
sudo cp bin/wifi-manager /usr/local/bin/
sudo chmod +x /usr/local/bin/wifi-manager
```

**Usage:**
```bash
wifi-manager list                    # List configured networks
wifi-manager connect "network-name"  # Connect to a network
wifi-manager disconnect              # Disconnect from WiFi
wifi-manager scan                    # Scan for networks
wifi-manager add "name" "password"   # Add new network
wifi-manager status                  # Show current status
```

**Configuration:**

Networks are stored in `~/.wifi-networks.json`:
```json
{
  "networks": [
    {
      "name": "network-name",
      "password": "password",
      "enabled": true
    }
  ]
}
```

## Setup Instructions

1. Clone this repository
2. Install scripts from `bin/` to `/usr/local/bin/`
3. Copy any config files to appropriate locations
4. Run setup scripts as needed

## Installed Software

- git
- cmake
- fastfetch (built from source)
- pyenv (installed to `~/.pyenv`)

