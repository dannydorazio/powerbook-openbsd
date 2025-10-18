#!/bin/sh
# INSTALLER_NAME: packages
# INSTALLER_DESC: Install essential system packages from packages.txt
# INSTALLER_VERSION: 1.0

echo "Installing essential packages..."
echo ""

SCRIPT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
PACKAGES_FILE="$SCRIPT_DIR/packages.txt"

if [ ! -f "$PACKAGES_FILE" ]; then
    echo "Error: packages.txt not found at $PACKAGES_FILE"
    return 1 2>/dev/null || exit 1
fi

# Parse packages from file (skip comments and empty lines)
PACKAGES=$(grep -v "^#" "$PACKAGES_FILE" | grep -v "^$" | tr "\\n" " ")

if [ -z "$PACKAGES" ]; then
    echo "No packages to install"
    return 0 2>/dev/null || exit 0
fi

echo "Packages to install:"
echo "$PACKAGES" | tr " " "\\n" | sed "s/^/  - /"
echo ""

echo "Installing packages..."
pkg_add $PACKAGES

if [ $? -eq 0 ]; then
    echo ""
    echo "✓ Packages installed successfully"
else
    echo ""
    echo "✗ Some packages may have failed to install"
    return 1 2>/dev/null || exit 1
fi
