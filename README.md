# Proxmox VE No-Subscription Warning Remover

This repository provides a simple shell script and an APT hook to safely remove the "No valid subscription" warning popup in the Proxmox Virtual Environment (PVE) web interface.

## Overview
By default, Proxmox VE displays a subscription warning dialogue every time you log into the web interface if you do not have an active enterprise subscription key. This repository contains tools to patch the `proxmox-widget-toolkit` to bypass this check, as well as an automation hook to ensure the patch survives system updates.

## Files Included
* `remove-sub-warning.sh`: A one-off executable bash script that backups the original file, applies the patch, and restarts the web interface.
* `99-pve-no-nag`: An APT hook configuration file that automatically reapplies the patch anytime Proxmox updates the widget toolkit.

## Usage

### 1. Manual Patching (One-Time)
To manually remove the warning, run the bash script on your Proxmox host:

```bash
chmod +x remove-sub-warning.sh
./remove-sub-warning.sh
