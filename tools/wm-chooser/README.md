# Window Manager Chooser

A simple tool to select which window manager to use at login on OpenBSD with xenodm.

## Background

xenodm (OpenBSD's display manager) doesn't have a built-in graphical session selector like GDM or LightDM. This tool provides two ways to choose your window manager:

1. **At first login**: A dialog box appears asking you to choose
2. **Anytime**: Run `wm-chooser` command to change your preference

## Available Window Managers

- **CWM** (Calm Window Manager) - OpenBSD's default, lightweight and keyboard-driven
- **Window Maker** - NeXTStep-style window manager with dock and clip
- **FVWM** - Classic F Virtual Window Manager
- **Openbox** - Lightweight stacking window manager
- **IceWM** - Windows 95-like interface, very customizable
- **Fluxbox** - Blackbox-based, minimal resource usage
- **JWM** (Joe's Window Manager) - Extremely tiny and fast
- **i3** - Tiling window manager for power users

**Note**: DWM is not available on OpenBSD macppc.

## Installation

The installer sets up:
1. Modified `.xsession` that shows a chooser on first login
2. `wm-chooser` command to change WM selection anytime
3. Your preference is saved in `~/.xsession-choice`

```sh
cd /root/powerbook-openbsd
./install.sh
```

## Usage

### First Login

When you log in for the first time after installation, you'll see a dialog box:

```
Choose your Window Manager

Select your window manager:

CWM - Lightweight, keyboard-driven
Window Maker - NeXTStep-style
FVWM - Classic window manager

[CWM] [Window Maker] [FVWM]
```

Click the button for your preferred WM. Your choice is remembered.

### Changing Window Manager

Run the chooser command anytime:

```sh
wm-chooser
```

You'll see:
```
Window Manager Chooser
======================

Available window managers:
  1) CWM - Calm Window Manager (minimal, keyboard-driven)
  2) Window Maker - NeXTStep-style (dock, clip)
  3) FVWM - F Virtual Window Manager (classic)
  4) Openbox - Lightweight stacking WM
  5) IceWM - Windows 95-like interface
  6) Fluxbox - Blackbox-based, very light
  7) JWM - Joe's Window Manager (tiny)
  8) i3 - Tiling window manager

Current choice: cwm

Select window manager (1-8) or press Enter to keep current:
```

Enter your choice (1-8) and log out/in to use the new window manager.

### Adding to CWM Menu

If you want quick access from CWM's application launcher:

Add to `~/.cwmrc`:
```
command wm-chooser "xterm -e wm-chooser"
```

Then press **Alt+?** and type "wm-chooser".

## Manual Selection

You can also manually edit `~/.xsession-choice`:

```sh
echo "cwm" > ~/.xsession-choice      # Use CWM
echo "wmaker" > ~/.xsession-choice   # Use Window Maker
echo "fvwm" > ~/.xsession-choice     # Use FVWM
echo "openbox" > ~/.xsession-choice  # Use Openbox
echo "icewm" > ~/.xsession-choice    # Use IceWM
echo "fluxbox" > ~/.xsession-choice  # Use Fluxbox
echo "jwm" > ~/.xsession-choice      # Use JWM
echo "i3" > ~/.xsession-choice       # Use i3
```

Then log out and log back in.

## Resetting to Show Chooser

To see the chooser dialog at next login:

```sh
rm ~/.xsession-choice
```

## Troubleshooting

### Dialog doesn't appear

1. Make sure `xmessage` is installed (should be by default)
2. Check `.xsession` is executable: `chmod +x ~/.xsession`
3. Check for errors in `/var/log/Xorg.0.log`

### Wrong WM starts

1. Check your choice file:
   ```sh
   cat ~/.xsession-choice
   ```
2. Make sure the WM is installed:
   ```sh
   which cwm wmaker fvwm
   ```

### Want to bypass chooser permanently

Edit `~/.xsession` and replace the chooser logic with a direct exec:

```sh
#!/bin/sh
exec /usr/X11R6/bin/cwm  # Or wmaker, or fvwm
```

## Compatibility

- **Tested on**: PowerBook G4 12" (PowerBook6,4)
- **OS**: OpenBSD 7.7 macppc
- **Display manager**: xenodm
- **Requires**: xmessage (included with X11)
