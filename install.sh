#!/bin/sh
# Installation script for PowerBook OpenBSD setup

echo "Installing powerbook-openbsd scripts..."

# Copy wifi-manager to system
if [ -f "bin/wifi-manager" ]; then
    cp bin/wifi-manager /usr/local/bin/
    chmod +x /usr/local/bin/wifi-manager
    echo "✓ wifi-manager installed to /usr/local/bin/"
else
    echo "✗ wifi-manager not found"
fi

echo ""
echo "Installation complete!"
echo ""
echo "Available commands:"
echo "  wifi-manager - Manage WiFi connections"
