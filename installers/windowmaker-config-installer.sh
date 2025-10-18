#!/bin/sh
# INSTALLER_NAME: windowmaker-config
# INSTALLER_DESC: Configure Window Maker (NeXTStep-style WM) as default
# INSTALLER_VERSION: 1.0

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
XSESSION_FILE="$SCRIPT_DIR/tools/windowmaker-config/xsession"

echo "→ Configuring Window Maker..."

# Check if Window Maker is installed
if ! command -v wmaker >/dev/null 2>&1; then
    echo "  Window Maker not found, installing..."
    pkg_add windowmaker
fi

# Get the user who should use Window Maker (not root)
# Assume the first non-root user with a home directory in /home
WM_USER=$(ls /home 2>/dev/null | head -1)

if [ -z "$WM_USER" ]; then
    echo "✗ No regular user found in /home"
    echo "  Please create a user first or run manually for specific user"
    exit 1
fi

USER_HOME="/home/$WM_USER"

echo "  Configuring for user: $WM_USER"

# Check if xsession template exists
if [ ! -f "$XSESSION_FILE" ]; then
    echo "✗ xsession template not found: $XSESSION_FILE"
    exit 1
fi

# Backup existing .xsession if it exists
if [ -f "$USER_HOME/.xsession" ]; then
    echo "  Backing up existing .xsession to .xsession.backup"
    cp "$USER_HOME/.xsession" "$USER_HOME/.xsession.backup"
fi

# Copy xsession file
cp "$XSESSION_FILE" "$USER_HOME/.xsession"
chmod +x "$USER_HOME/.xsession"
chown "$WM_USER:$WM_USER" "$USER_HOME/.xsession"

# Wait a moment for Window Maker to create its default config if user logs in
# Otherwise, we'll configure it on next run
if [ -f "$USER_HOME/GNUstep/Defaults/WindowMaker" ]; then
    echo "  Configuring mouse button emulation..."
    # Add Control+Click for right-click emulation
    if ! grep -q "MouseButton3Modifier" "$USER_HOME/GNUstep/Defaults/WindowMaker"; then
        awk '/ModifierKey = Mod1;/ {print; print "\tMouseButton2Modifier = Mod1;"; print "\tMouseButton3Modifier = Control;"; next}1' \
            "$USER_HOME/GNUstep/Defaults/WindowMaker" > /tmp/WindowMaker.new
        mv /tmp/WindowMaker.new "$USER_HOME/GNUstep/Defaults/WindowMaker"
        chown "$WM_USER:$WM_USER" "$USER_HOME/GNUstep/Defaults/WindowMaker"
        echo "  ✓ Mouse button emulation configured"
    fi
fi

echo "✓ Window Maker configured for user $WM_USER"
echo ""
echo "  To activate:"
echo "    1. Log out of X11"
echo "    2. Log back in via xenodm"
echo ""
echo "  Window Maker will start automatically!"
echo "  Control+Click will work as right-click"
echo ""
echo "  Note: If Control+Click doesn't work, log out and log back in again"
echo "  to allow Window Maker to create its config, then run this installer again."
