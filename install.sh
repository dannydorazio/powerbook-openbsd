#!/bin/sh
# Master installation script for PowerBook OpenBSD setup
# This script runs all installers in the installers/ directory

echo "================================="
echo "PowerBook OpenBSD Setup Installer"
echo "================================="
echo ""

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
INSTALLERS_DIR="$SCRIPT_DIR/installers"

# Check if installers directory exists
if [ ! -d "$INSTALLERS_DIR" ]; then
    echo "Error: installers directory not found at $INSTALLERS_DIR"
    exit 1
fi

# Count total installers
total_installers=$(find "$INSTALLERS_DIR" -name "*-installer.sh" -type f | wc -l | tr -d " ")

if [ "$total_installers" -eq 0 ]; then
    echo "No installers found in $INSTALLERS_DIR"
    exit 0
fi

echo "Found $total_installers installer(s) to run"
echo ""

# Run each installer
for installer in "$INSTALLERS_DIR"/*-installer.sh; do
    if [ -f "$installer" ]; then
        installer_name=$(basename "$installer")
        echo "Running $installer_name..."
        echo "---"
        
        # Make sure installer is executable
        chmod +x "$installer"
        
        # Run the installer
        if sh "$installer"; then
            echo "✓ $installer_name completed successfully"
        else
            echo "✗ $installer_name failed"
        fi
        echo ""
    fi
done

echo "================================="
echo "Installation Complete!"
echo "================================="
