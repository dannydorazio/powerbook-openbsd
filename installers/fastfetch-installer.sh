#!/bin/sh
# INSTALLER_NAME: fastfetch
# INSTALLER_DESC: System information tool (built from source)
# INSTALLER_VERSION: 1.0

echo "Installing fastfetch from source..."
echo ""

# Check if fastfetch is already installed
if command -v fastfetch >/dev/null 2>&1; then
    echo "fastfetch is already installed:"
    fastfetch --version
    echo ""
    echo "Skip installation? (y/n, default: y)"
    read -r skip
    if [ -z "$skip" ] || [ "$skip" = "y" ] || [ "$skip" = "Y" ]; then
        echo "Skipping installation."
        return 0 2>/dev/null || exit 0
    fi
fi

# Install dependencies
echo "Installing build dependencies..."
pkg_add cmake git

if [ $? -ne 0 ]; then
    echo "Failed to install dependencies"
    return 1 2>/dev/null || exit 1
fi

# Clone fastfetch
BUILD_DIR="/tmp/fastfetch-build-$$"
echo ""
echo "Cloning fastfetch repository to $BUILD_DIR..."
git clone https://github.com/fastfetch-cli/fastfetch.git "$BUILD_DIR"

if [ $? -ne 0 ]; then
    echo "Failed to clone fastfetch repository"
    return 1 2>/dev/null || exit 1
fi

# Build fastfetch
echo ""
echo "Building fastfetch (this may take several minutes on PowerPC)..."
cd "$BUILD_DIR"
mkdir build
cd build

if ! cmake ..; then
    echo "CMake configuration failed"
    cd /
    rm -rf "$BUILD_DIR"
    return 1 2>/dev/null || exit 1
fi

if ! make; then
    echo "Build failed"
    cd /
    rm -rf "$BUILD_DIR"
    return 1 2>/dev/null || exit 1
fi

# Install fastfetch
echo ""
echo "Installing fastfetch..."
if ! make install; then
    echo "Installation failed"
    cd /
    rm -rf "$BUILD_DIR"
    return 1 2>/dev/null || exit 1
fi

# Clean up
cd /
echo ""
echo "Cleaning up build directory..."
rm -rf "$BUILD_DIR"

echo ""
echo "✓ fastfetch installed successfully"
echo ""
fastfetch --version
