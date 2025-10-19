#!/bin/sh
# INSTALLER_NAME: wm-chooser
# INSTALLER_DESC: Window manager selector for xenodm login
# INSTALLER_VERSION: 1.0

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
WM_CHOOSER="$SCRIPT_DIR/tools/wm-chooser/wm-chooser"
XSESSION_FILE="$SCRIPT_DIR/tools/wm-chooser/xsession-with-chooser"

echo "→ Installing Window Manager Chooser..."

# Get the user
WM_USER=$(ls /home 2>/dev/null | head -1)

if [ -z "$WM_USER" ]; then
    echo "✗ No regular user found in /home"
    exit 1
fi

USER_HOME="/home/$WM_USER"

echo "  Installing for user: $WM_USER"

# Check if files exist
if [ ! -f "$WM_CHOOSER" ]; then
    echo "✗ wm-chooser script not found: $WM_CHOOSER"
    exit 1
fi

if [ ! -f "$XSESSION_FILE" ]; then
    echo "✗ xsession template not found: $XSESSION_FILE"
    exit 1
fi

# Install wm-chooser command
cp "$WM_CHOOSER" /usr/local/bin/
chmod +x /usr/local/bin/wm-chooser
echo "  ✓ Installed wm-chooser command to /usr/local/bin/"

# Backup existing .xsession
if [ -f "$USER_HOME/.xsession" ]; then
    echo "  Backing up existing .xsession to .xsession.backup"
    cp "$USER_HOME/.xsession" "$USER_HOME/.xsession.backup"
fi

# Install new .xsession with chooser
cp "$XSESSION_FILE" "$USER_HOME/.xsession"
chmod +x "$USER_HOME/.xsession"
chown "$WM_USER:$WM_USER" "$USER_HOME/.xsession"
echo "  ✓ Installed session chooser to .xsession"

# Remove any existing choice to show chooser at next login
if [ -f "$USER_HOME/.xsession-choice" ]; then
    rm "$USER_HOME/.xsession-choice"
    echo "  ✓ Removed existing choice - chooser will appear at next login"
fi

echo ""
echo "✓ Window Manager Chooser installed"
echo ""
echo "  At next login, you'll see a dialog to choose your WM:"
echo "    - CWM (lightweight, keyboard-driven)"
echo "    - Window Maker (NeXTStep-style)"
echo "    - FVWM (classic WM)"
echo ""
echo "  To change your choice later, run: wm-chooser"
echo ""
echo "  Log out and log back in to see the chooser!"
