# CWM Configuration

CWM (Calm Window Manager) is OpenBSD's default window manager - lightweight, keyboard-driven, and perfect for vintage hardware.

## Features

- **Minimal resource usage**: Perfect for PowerBook G4
- **Keyboard-centric**: Extensive keybindings for quick navigation
- **Virtual desktops**: 5 groups/workspaces configured
- **Clean interface**: Simple borders, no decorations
- **Fast**: Immediate response even on PowerPC

## Installation

The installer will:
1. Copy `.cwmrc` configuration to user's home directory
2. Set up `.xsession` to launch CWM
3. Configure custom keybindings and colors

Run the installer:
```sh
cd /root/powerbook-openbsd
./install.sh
```

Or manually:
```sh
cp tools/cwm-config/cwmrc ~/.cwmrc
cp tools/cwm-config/xsession ~/.xsession
chmod +x ~/.xsession
```

## Activation

After installation, log out and log back in via xenodm. CWM will start automatically.

To switch immediately:
```sh
pkill X
# Log back in via xenodm
```

## Keyboard Shortcuts

### Window Management
- **Cmd+Enter** (or **Alt+Shift+Enter**): Open terminal
- **Alt+/**: Window menu (search open windows)
- **Alt+?** (Alt+Shift+/): Application launcher
- **Alt+.**: SSH menu
- **Alt+Tab**: Cycle through windows

### Window Operations
- **Alt+Shift+Q**: Close current window
- **Alt+F**: Toggle fullscreen
- **Alt+M**: Maximize window
- **Alt+=**: Maximize vertically
- **Alt+H**: Hide window

### Window Positioning (Alt + Arrow Keys)
- **Alt+Left**: Snap window to left half
- **Alt+Right**: Snap window to right half
- **Alt+Up**: Snap window to top
- **Alt+Down**: Snap window to bottom

### Window Resizing (Ctrl+Alt + Arrow Keys)
- **Ctrl+Alt+Left**: Shrink window from right edge
- **Ctrl+Alt+Right**: Grow window to the right
- **Ctrl+Alt+Up**: Shrink window from bottom edge
- **Ctrl+Alt+Down**: Grow window downward
- **Ctrl+Alt+Shift+Arrows**: Resize in larger increments

### Virtual Desktops/Groups
- **Alt+1** through **Alt+5**: Switch to workspace 1-5
- **Alt+Shift+1** through **Alt+Shift+5**: Move window to workspace 1-5

### Mouse Operations
- **Alt+Left-Click**: Move window
- **Alt+Middle-Click**: Hide window
- **Alt+Right-Click**: Resize window

## Application Launcher

Press **Alt+?** (Alt+Shift+/) to open the application menu. Configured applications:
- `terminal` - xterm
- `dillo` - Dillo web browser
- `netsurf` - NetSurf web browser
- `files` - File manager (if installed)
- `top` - htop system monitor

Type the application name and press Enter to launch.

## Customization

### Colors

The configuration uses a Nord-inspired color scheme:
- **Active border**: Blue (#4c7899)
- **Inactive border**: Dark gray (#333333)
- **Menu background**: Dark (#2e3440)
- **Selected item**: Light blue (#88c0d0)

To customize, edit `~/.cwmrc` and change the `color` lines.

### Adding Applications

Add new applications to the launcher menu in `~/.cwmrc`:

```sh
command myapp "myapp-binary-name"
```

Then restart CWM: **Alt+Q** (quit CWM) and log back in.

### Keybindings

All keybindings are in `~/.cwmrc`. Format:
```sh
bind-key M-x command-name  # M = Alt/Meta
bind-key 4-x command-name  # 4 = Command/Windows key
bind-key C-x command-name  # C = Control
bind-key S-x command-name  # S = Shift
```

Combine modifiers: `MS-x` = Alt+Shift+x

## Web Browsing

Two lightweight browsers are configured:

### Dillo
- **Very lightweight**: Minimal resource usage
- **Fast**: Quick rendering
- **Limited**: No JavaScript, basic CSS
- **Good for**: Reading documentation, simple sites
- Launch: Type `dillo` in application launcher (Alt+?)

### NetSurf
- **Lightweight**: More capable than Dillo
- **Better rendering**: Improved CSS support
- **Some JavaScript**: Limited JS support
- **Good for**: Modern static sites, better rendering
- Launch: Type `netsurf` in application launcher (Alt+?)

**Note**: Modern browsers (Firefox, Chromium) are NOT available on OpenBSD macppc.

## Tips for PowerBook G4

1. **Use keyboard shortcuts**: Faster than mouse on PowerPC
2. **Organize with groups**: Keep related apps on same workspace
3. **Hide instead of close**: Faster to unhide than relaunch
4. **Minimize decorations**: CWM already has minimal UI
5. **Terminal-centric workflow**: Many tasks faster in terminal

## Troubleshooting

### CWM doesn't start

1. Check if `.xsession` is executable:
   ```sh
   chmod +x ~/.xsession
   ```

2. Check for syntax errors in `.cwmrc`:
   ```sh
   cwm -c ~/.cwmrc -n
   ```

### Keybindings don't work

1. Make sure you're using the right modifier:
   - `M` = Alt key
   - `4` = Command/Windows key
   - `C` = Control
   - `S` = Shift

2. Check for conflicts in `.cwmrc`

### Want to go back to FVWM/Window Maker

Remove or rename `.xsession`:
```sh
mv ~/.xsession ~/.xsession.backup
# System default (FVWM) will start
```

Or modify `.xsession` to launch a different WM:
```sh
exec wmaker  # For Window Maker
exec fvwm    # For FVWM
```

## Resources

- [CWM Manual](https://man.openbsd.org/cwm)
- [CWM Config Manual](https://man.openbsd.org/cwmrc)

## Compatibility

- **Tested on**: PowerBook G4 12" (PowerBook6,4)
- **OS**: OpenBSD 7.7 macppc
- **Display manager**: xenodm
- **Shell**: ksh (default OpenBSD shell)
