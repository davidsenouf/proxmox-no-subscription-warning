#!/bin/bash

# Define the target file
TARGET_FILE="/usr/share/javascript/proxmox-widget-toolkit/proxmoxlib.js"

# Check if the file exists
if [ ! -f "$TARGET_FILE" ]; then
    echo "Error: Could not find $TARGET_FILE. Are you running this on the Proxmox host?"
    exit 1
fi

echo "Creating backup at ${TARGET_FILE}.bak..."
cp "$TARGET_FILE" "${TARGET_FILE}.bak"

echo "Patching Proxmox subscription verification..."
# Inject an immediate return into the subscription check function
sed -Ezi "s/(function ?\(orig_cmd\) \{)/\1\n\torig_cmd\(\);\n\treturn;/g" "$TARGET_FILE"

echo "Restarting Proxmox web interface (pveproxy)..."
systemctl restart pveproxy.service

echo -e "\nSuccess! The 'No valid subscription' warning has been removed."
echo "IMPORTANT: You must clear your browser cache (or press Ctrl+Shift+R / Shift+F5) for the changes to appear."
