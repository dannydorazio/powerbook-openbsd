#!/bin/sh
# INSTALLER_NAME: trackpad-config
# INSTALLER_DESC: Enable Control+Click for right-click on trackpad
# INSTALLER_VERSION: 1.0

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
CONFIG_FILE="$SCRIPT_DIR/tools/trackpad-config/10-trackpad.conf"
TARGET_DIR="/etc/X11/xorg.conf.d"
TARGET_FILE="$TARGET_DIR/10-trackpad.conf"

echo "→ Installing trackpad configuration..."

# Check if config file exists in repo
if [ ! -f "$CONFIG_FILE" ]; then
    echo "✗ Configuration file not found: $CONFIG_FILE"
    exit 1
fi

# Create target directory if it doesn't exist
if [ ! -d "$TARGET_DIR" ]; then
    echo "  Creating $TARGET_DIR"
    mkdir -p "$TARGET_DIR"
fi

# Check if already installed
if [ -f "$TARGET_FILE" ]; then
    echo "  Trackpad config already exists, updating..."
fi

# Copy config file
cp "$CONFIG_FILE" "$TARGET_FILE"
chmod 644 "$TARGET_FILE"

echo "✓ Trackpad configuration installed to $TARGET_FILE"
echo ""
echo "  To apply changes:"
echo "    1. Restart X11: pkill X"
echo "    2. Log back in via xenodm"
echo ""
echo "  After restart, Control+Click will act as right-click"
