# Proxmox VE No-Subscription Warning Remover

This repository provides a simple shell script and an APT hook to safely remove the "No valid subscription" warning popup in the Proxmox Virtual Environment (PVE) web interface.

## Overview
By default, Proxmox VE displays a subscription warning dialogue every time you log into the web interface if you do not have an active enterprise subscription key. This repository contains tools to patch the `proxmox-widget-toolkit` to bypass this check, as well as an automation hook to ensure the patch survives system updates.

## Files Included
* `remove-sub-warning.sh`: A one-off executable bash script that backups the original file, applies the patch, and restarts the web interface.
* `99-pve-no-nag`: An APT hook configuration file that automatically reapplies the patch anytime Proxmox updates the widget toolkit.

## Usage

### Manual Patching (One-Time)
To manually remove the warning, run the bash script on your Proxmox host:

```bash
chmod +x remove-sub-warning.sh
./remove-sub-warning.sh

### Automated Patching (APT Hook)
Since Proxmox updates will periodically overwrite the patched JavaScript file, you can install the APT hook to ensure the warning stays hidden permanently.

Copy the hook file to your APT configuration directory:

```bash
cp 99-pve-no-nag /etc/apt/apt.conf.d/99-pve-no-nag

### Uninstallation (Restore Default Behavior)
If you ever want to revert these changes and restore the original Proxmox subscription warning, you can run the included `uninstall.sh` script:

```bash
chmod +x uninstall.sh
./uninstall.sh

This script will automatically:

Restore the backup of the original proxmoxlib.js file.

Remove the 99-pve-no-nag APT hook so the patch does not automatically reapply during the next update.

Restart the pveproxy web interface service.

Note: If the .bak backup file was accidentally deleted, you can manually force the system to restore the original, unmodified Proxmox file by reinstalling the toolkit directly via the package manager: apt install --reinstall proxmox-widget-toolkit. Just remember to clear your browser cache afterward!
