#!/bin/sh
# INSTALLER_NAME: wifi-manager
# INSTALLER_DESC: WiFi network management tool for OpenBSD
# INSTALLER_VERSION: 1.0

echo "Installing wifi-manager..."

SCRIPT_DIR="$(cd "$(dirname "$0")/.." && pwd)"

# Copy wifi-manager to system
if [ -f "$SCRIPT_DIR/tools/wifi-manager/wifi-manager" ]; then
    cp "$SCRIPT_DIR/tools/wifi-manager/wifi-manager" /usr/local/bin/
    chmod +x /usr/local/bin/wifi-manager
    echo "✓ wifi-manager installed to /usr/local/bin/"
else
    echo "✗ wifi-manager not found at $SCRIPT_DIR/tools/wifi-manager/wifi-manager"
    return 1 2>/dev/null || exit 1
fi

echo ""
echo "Installation complete!"
echo ""
echo "Usage: wifi-manager <command>"
echo "See: tools/wifi-manager/README.md for documentation"
