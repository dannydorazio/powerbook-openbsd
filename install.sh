#!/bin/sh
# Master installation script for PowerBook OpenBSD setup
# Automatically discovers and runs installers from installers/ directory

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

# Function to extract metadata from installer
get_metadata() {
    file="$1"
    field="$2"
    grep "^# INSTALLER_$field:" "$file" | head -1 | sed "s/^# INSTALLER_$field: *//"
}

# Discover installers
TEMP_LIST="/tmp/installer_list_$$"
> "$TEMP_LIST"

count=0
for installer in "$INSTALLERS_DIR"/*-installer.sh; do
    if [ -f "$installer" ]; then
        count=$((count + 1))
        name=$(get_metadata "$installer" "NAME")
        desc=$(get_metadata "$installer" "DESC")
        
        # Fallback to filename if no metadata
        if [ -z "$name" ]; then
            name=$(basename "$installer" -installer.sh)
        fi
        if [ -z "$desc" ]; then
            desc="No description available"
        fi
        
        echo "$count|$name|$desc|$installer" >> "$TEMP_LIST"
    fi
done

if [ "$count" -eq 0 ]; then
    echo "No installers found"
    rm -f "$TEMP_LIST"
    exit 0
fi

# Display menu
echo "Available installers:"
echo ""

while IFS="|" read -r num name desc path; do
    printf "  %s) %-20s - %s\n" "$num" "$name" "$desc"
done < "$TEMP_LIST"

echo ""
echo "Enter installer numbers to run (space-separated), or press Enter for all:"
read -r selection

# Determine which to run
if [ -z "$selection" ]; then
    # Run all
    SELECTED_NUMS=$(seq 1 "$count")
else
    SELECTED_NUMS="$selection"
fi

echo ""
echo "Running selected installers..."
echo ""

# Run selected installers
for num in $SELECTED_NUMS; do
    installer_path=$(grep "^$num|" "$TEMP_LIST" | cut -d"|" -f4)
    
    if [ -n "$installer_path" ] && [ -f "$installer_path" ]; then
        name=$(grep "^$num|" "$TEMP_LIST" | cut -d"|" -f2)
        echo "[$num/$count] Installing: $name"
        echo "---"
        
        chmod +x "$installer_path"
        if sh "$installer_path"; then
            echo "✓ $name completed successfully"
        else
            echo "✗ $name failed"
        fi
        echo ""
    fi
done

rm -f "$TEMP_LIST"

echo "================================="
echo "Installation Complete!"
echo "================================="
