# Trackpad Configuration for PowerBook G4

This tool helps configure the PowerBook G4 trackpad on OpenBSD to enable Control+Click for right-click functionality.

## Background

On PowerBook G4 systems running OpenBSD, the trackpad is controlled by the ADB (Apple Desktop Bus) driver. The built-in trackpad typically supports:
- **Tap to click**: Tapping the trackpad acts as a left-click
- **Control+Click**: Holding Control while clicking acts as a right-click (button 3)

However, this functionality needs to be properly configured at the X11 level.

## Solution

Since OpenBSD on PowerBook G4 uses the `ums` (USB mouse) or ADB mouse drivers, we configure X11 to emulate 3-button mouse behavior using the `Emulate3Buttons` option.

This configuration file (`/usr/X11R6/share/X11/xorg.conf.d/10-trackpad.conf`) enables:
1. **Emulate3Buttons**: Control+Click becomes right-click
2. **Emulate3Timeout**: How long to wait (in ms) for the control key

## Installation

Run the installer:
```sh
cd /root/powerbook-openbsd
./install.sh
```

Or manually:
```sh
cp tools/trackpad-config/10-trackpad.conf /usr/X11R6/share/X11/xorg.conf.d/
```

Then restart X11 or reboot.

## Usage

After installation:
- **Left-click**: Tap or press the trackpad button
- **Right-click**: Hold left Control key and click/tap
- **Middle-click**: Hold both Control keys and click (if needed)

## Verification

To verify the configuration is loaded:
```sh
grep -r Emulate3 /var/log/Xorg.0.log
```

## Compatibility

- **Tested on**: PowerBook G4 12" (PowerBook6,4)
- **OS**: OpenBSD 7.7 macppc
- **X11**: X.Org X Server

## Troubleshooting

### Right-click not working

1. Check if X11 loaded the config:
   ```sh
   grep -i trackpad /var/log/Xorg.0.log
   ```

2. Verify the config file exists:
   ```sh
   ls -la /usr/X11R6/share/X11/xorg.conf.d/10-trackpad.conf
   ```

3. Try restarting X11:
   ```sh
   pkill X
   # Log back in via xenodm
   ```

### Config not loading

The config directory `/usr/X11R6/share/X11/xorg.conf.d` should exist on any standard OpenBSD X11 installation. If it doesn't, you may need to reinstall X11 packages.
