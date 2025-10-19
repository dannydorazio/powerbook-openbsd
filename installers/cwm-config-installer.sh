#!/bin/sh
# INSTALLER_NAME: cwm-config
# INSTALLER_DESC: Configure CWM (Calm Window Manager) as default with custom config
# INSTALLER_VERSION: 1.0

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
CWMRC_FILE="$SCRIPT_DIR/tools/cwm-config/cwmrc"
XSESSION_FILE="$SCRIPT_DIR/tools/cwm-config/xsession"

echo "→ Configuring CWM..."

# Get the user who should use CWM (not root)
# Assume the first non-root user with a home directory in /home
CWM_USER=$(ls /home 2>/dev/null | head -1)

if [ -z "$CWM_USER" ]; then
    echo "✗ No regular user found in /home"
    echo "  Please create a user first or run manually for specific user"
    exit 1
fi

USER_HOME="/home/$CWM_USER"

echo "  Configuring for user: $CWM_USER"

# Check if config files exist
if [ ! -f "$CWMRC_FILE" ]; then
    echo "✗ cwmrc template not found: $CWMRC_FILE"
    exit 1
fi

if [ ! -f "$XSESSION_FILE" ]; then
    echo "✗ xsession template not found: $XSESSION_FILE"
    exit 1
fi

# Backup existing configs if they exist
if [ -f "$USER_HOME/.cwmrc" ]; then
    echo "  Backing up existing .cwmrc to .cwmrc.backup"
    cp "$USER_HOME/.cwmrc" "$USER_HOME/.cwmrc.backup"
fi

if [ -f "$USER_HOME/.xsession" ]; then
    echo "  Backing up existing .xsession to .xsession.backup"
    cp "$USER_HOME/.xsession" "$USER_HOME/.xsession.backup"
fi

# Copy config files
cp "$CWMRC_FILE" "$USER_HOME/.cwmrc"
cp "$XSESSION_FILE" "$USER_HOME/.xsession"

chmod 644 "$USER_HOME/.cwmrc"
chmod +x "$USER_HOME/.xsession"
chown "$CWM_USER:$CWM_USER" "$USER_HOME/.cwmrc" "$USER_HOME/.xsession"

echo "✓ CWM configured for user $CWM_USER"
echo ""
echo "  Configuration includes:"
echo "    - Custom keybindings (Alt+Enter for terminal, Alt+/ for windows, etc.)"
echo "    - 5 virtual desktops/workspaces"
echo "    - Nord-inspired color scheme"
echo "    - Browser launchers (dillo, netsurf)"
echo ""
echo "  To activate:"
echo "    1. Log out of X11"
echo "    2. Log back in via xenodm"
echo ""
echo "  CWM will start automatically!"
echo ""
echo "  Quick shortcuts:"
echo "    Alt+Enter       - Open terminal"
echo "    Alt+/           - Window menu"
echo "    Alt+?           - Application launcher"
echo "    Alt+Shift+Q     - Close window"
echo "    Alt+1-5         - Switch workspaces"
