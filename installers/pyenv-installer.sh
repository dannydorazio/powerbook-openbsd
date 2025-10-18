#!/bin/sh
# Installer for pyenv

echo "Installing pyenv..."
echo ""

PYENV_ROOT="${HOME}/.pyenv"

# Check if pyenv is already installed
if [ -d "$PYENV_ROOT" ]; then
    echo "pyenv is already installed at $PYENV_ROOT"
    echo "Skipping installation."
    return 0 2>/dev/null || exit 0
fi

# Install git if not present
if ! command -v git >/dev/null 2>&1; then
    echo "Installing git..."
    pkg_add git
fi

# Clone pyenv
echo "Cloning pyenv repository..."
git clone https://github.com/pyenv/pyenv.git "$PYENV_ROOT"

if [ $? -ne 0 ]; then
    echo "Failed to clone pyenv"
    return 1 2>/dev/null || exit 1
fi

# Add to shell profile if not already there
if ! grep -q "PYENV_ROOT" ~/.profile 2>/dev/null; then
    echo ""
    echo "Adding pyenv to ~/.profile..."
    cat >> ~/.profile << "EOFPROFILE"

# pyenv configuration
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
EOFPROFILE
    echo "✓ Added pyenv to ~/.profile"
else
    echo "pyenv already configured in ~/.profile"
fi

echo ""
echo "✓ pyenv installed successfully"
echo ""
echo "To use pyenv in your current shell, run:"
echo "  export PYENV_ROOT=\"\$HOME/.pyenv\""
echo "  export PATH=\"\$PYENV_ROOT/bin:\$PATH\""
echo "  eval \"\$(pyenv init -)\""
echo ""
echo "Or start a new shell session."
