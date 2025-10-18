#!/bin/sh
# Master installation script for PowerBook OpenBSD setup

echo "================================="
echo "PowerBook OpenBSD Setup Installer"
echo "================================="
echo ""

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
INSTALLERS_DIR="$SCRIPT_DIR/installers"

if [ ! -d "$INSTALLERS_DIR" ]; then
    echo "Error: installers directory not found"
    exit 1
fi

# Build list of installers
INSTALLER_LIST=""
count=0
for installer in "$INSTALLERS_DIR"/*-installer.sh; do
    if [ -f "$installer" ]; then
        count=$((count + 1))
        INSTALLER_LIST="$INSTALLER_LIST$installer
"
    fi
done

if [ "$count" -eq 0 ]; then
    echo "No installers found"
    exit 0
fi

echo "Available installers:"
echo ""

# Display menu
i=1
echo "$INSTALLER_LIST" | while IFS= read -r installer; do
    if [ -n "$installer" ]; then
        name=$(basename "$installer" -installer.sh)
        printf "  %d) %s\n" "$i" "$name"
        i=$((i + 1))
    fi
done

echo ""
echo "Enter installer numbers to run (space-separated), or press Enter for all:"
read -r selection

# Determine which to run
if [ -z "$selection" ]; then
    # Run all
    SELECTED="$INSTALLER_LIST"
else
    # Build selected list
    SELECTED=""
    for num in $selection; do
        i=1
        echo "$INSTALLER_LIST" | while IFS= read -r installer; do
            if [ -n "$installer" ] && [ "$i" -eq "$num" ]; then
                echo "$installer"
                break
            fi
            i=$((i + 1))
        done
    done > /tmp/selected_installers_$$
    SELECTED=$(cat /tmp/selected_installers_$$)
    rm -f /tmp/selected_installers_$$
fi

echo ""
echo "Running selected installers..."
echo ""

# Run installers
echo "$SELECTED" | while IFS= read -r installer; do
    if [ -n "$installer" ] && [ -f "$installer" ]; then
        name=$(basename "$installer")
        echo "Running $name..."
        echo "---"
        chmod +x "$installer"
        if sh "$installer"; then
            echo "✓ $name completed"
        else
            echo "✗ $name failed"
        fi
        echo ""
    fi
done

echo "================================="
echo "Installation Complete!"
echo "================================="
