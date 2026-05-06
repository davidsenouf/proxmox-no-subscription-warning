#!/bin/bash

# Define the file paths
TARGET_FILE="/usr/share/javascript/proxmox-widget-toolkit/proxmoxlib.js"
BACKUP_FILE="${TARGET_FILE}.bak"
APT_HOOK="/etc/apt/apt.conf.d/99-pve-no-nag"

echo "Starting uninstallation process..."

# 1. Restore the original Proxmox UI file
if [ -f "$BACKUP_FILE" ]; then
    echo "Restoring original proxmoxlib.js from backup..."
    mv "$BACKUP_FILE" "$TARGET_FILE"
else
    echo "Warning: Backup file ($BACKUP_FILE) not found."
    echo "If the warning doesn't return, you can manually restore it by running: apt-get install --reinstall proxmox-widget-toolkit"
fi

# 2. Remove the APT hook
if [ -f "$APT_HOOK" ]; then
    echo "Removing automated APT hook..."
    rm "$APT_HOOK"
else
    echo "APT hook not found. Skipping."
fi

# 3. Restart the web interface
echo "Restarting Proxmox web interface (pveproxy)..."
systemctl restart pveproxy.service

echo -e "\nUninstallation complete! The subscription warning has been restored."
echo "IMPORTANT: You must clear your browser cache (or press Ctrl+Shift+R / Shift+F5) for the original behavior to reappear."
