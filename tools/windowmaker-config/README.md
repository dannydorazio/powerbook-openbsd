# Window Maker Configuration

Window Maker is a classic NeXTStep-style window manager that brings the look and feel of the NeXT operating system to modern Unix systems.

## Features

- **NeXTStep-inspired interface**: Dock, clip, and application icons
- **Lightweight**: Perfect for vintage hardware like PowerBook G4
- **Highly customizable**: Themes, appearance, and behavior
- **Classic aesthetics**: Beautiful retro computing experience

## Installation

The installer will:
1. Install Window Maker package (if not already installed)
2. Configure user's `.xsession` to launch Window Maker
3. Set up a nice default background color

Run the installer:
```sh
cd /root/powerbook-openbsd
./install.sh
```

Or manually:
```sh
pkg_add windowmaker
cp tools/windowmaker-config/xsession ~/.xsession
chmod +x ~/.xsession
```

## Mouse Button Emulation

Window Maker needs special configuration to support Control+Click for right-click (button 3 emulation).

The configuration includes:
- `MouseButton2Modifier = Mod1;` - Alt+Click for middle-click
- `MouseButton3Modifier = Control;` - Control+Click for right-click

This is automatically configured by the installer.

## Activation

After installation, log out and log back in via xenodm. Window Maker will start automatically.

To switch immediately without logging out:
```sh
pkill X
# Log back in via xenodm
```

## Usage

### Basic Navigation

- **Right-click on desktop**: Opens applications menu
- **Middle-click on desktop**: Opens window list menu
- **The Dock**: Located on the right side
  - Drag applications here to create shortcuts
  - Right-click dock icons for options
- **The Clip**: Paper clip icon for workspace-specific apps
- **Workspaces**: Use the workspace switcher in the dock

### Keyboard Shortcuts

- **Alt+Tab**: Cycle through windows
- **Alt+F1 to F10**: Switch to workspace 1-10
- **Alt+Shift+F1**: Open applications menu
- **Alt+Escape**: Hide current application

### Customization

Right-click the desktop and select:
- **Preferences**: Customize appearance, themes, and behavior
- **Appearance**: Change window styles, colors, and fonts
- **Themes**: Choose from built-in themes or create your own

Configuration files are stored in `~/GNUstep/Defaults/`

## Themes

Window Maker comes with several built-in themes. To change:
1. Right-click desktop
2. Select **Appearance** → **Themes**
3. Choose a theme and click "OK"

Popular themes for the retro NeXT look:
- **NeXT**: Classic NeXTStep appearance (default)
- **BlueDecor**: Blue-tinted NeXT style
- **Checker**: Checkered pattern theme

## Tips for PowerBook G4

- **Disable animations**: Speeds up window operations
  - Preferences → Animations → Disable unnecessary effects
- **Use simple backgrounds**: Solid colors perform better than images
- **Optimize dock**: Don't overload it with too many apps

## Troubleshooting

### Window Maker doesn't start

1. Check if `.xsession` is executable:
   ```sh
   chmod +x ~/.xsession
   ```

2. Check X11 logs:
   ```sh
   tail /var/log/Xorg.0.log
   ```

3. Verify Window Maker is installed:
   ```sh
   which wmaker
   ```

### Want to switch back to default WM

Edit or remove `~/.xsession`:
```sh
rm ~/.xsession
# The system default WM (usually cwm or fvwm) will start
```

## Resources

- [Window Maker Documentation](https://www.windowmaker.org/docs.php)
- [Window Maker Themes](https://www.windowmaker.org/themes.php)

## Compatibility

- **Tested on**: PowerBook G4 12" (PowerBook6,4)
- **OS**: OpenBSD 7.7 macppc
- **Display manager**: xenodm
