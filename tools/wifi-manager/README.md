# wifi-manager

A WiFi network management tool for OpenBSD, designed for easy command-line WiFi configuration.

## Features

- List configured networks from a JSON config file
- Connect to networks with saved credentials
- Scan for available WiFi networks
- Add new networks to configuration
- Disconnect from WiFi
- View current connection status
- Automatically updates `/etc/hostname.<interface>` for persistence across reboots

## Installation

```bash
sudo cp wifi-manager /usr/local/bin/
sudo chmod +x /usr/local/bin/wifi-manager
```

Or from the repository root:
```bash
./install.sh
# Then select the wifi-manager installer
```

## Configuration

Networks are stored in `~/.wifi-networks.json`:

```json
{
  "networks": [
    {
      "name": "MyNetwork",
      "password": "mypassword",
      "enabled": true
    }
  ]
}
```

**Note:** This file contains passwords in plain text. Ensure proper file permissions:
```bash
chmod 600 ~/.wifi-networks.json
```

## Usage

### List configured networks
```bash
wifi-manager list
```

### Connect to a network
```bash
wifi-manager connect "NetworkName"
```

### Scan for available networks
```bash
wifi-manager scan
```

### Add a new network
```bash
wifi-manager add "NetworkName" "password"
```

### Check connection status
```bash
wifi-manager status
```

### Disconnect from WiFi
```bash
wifi-manager disconnect
```

## Technical Details

- **WiFi Interface:** Defaults to `bwi0` (configurable in script)
- **DHCP:** Uses OpenBSD's `dhcpleased` for IP assignment
- **WPA:** Supports WPA2 with PSK authentication
- **Persistence:** Creates/updates `/etc/hostname.bwi0` for boot persistence

## Compatibility

Tested on:
- OpenBSD 7.7 (macppc)
- PowerBook G4 12" with Broadcom WiFi (bwi0)

May work on other OpenBSD systems with different WiFi interfaces - edit the `WIFI_INTERFACE` variable in the script.

## Security Notes

- Passwords are stored in plain text in `~/.wifi-networks.json`
- The file is created with 600 permissions (owner read/write only)
- `/etc/hostname.bwi0` also contains the WPA key
- This tool is designed for single-user systems or trusted environments

## License

MIT License - Feel free to modify and distribute
