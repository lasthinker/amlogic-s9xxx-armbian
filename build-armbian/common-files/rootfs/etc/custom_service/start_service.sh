#!/bin/bash

# Set the release check file
lasthinker_release_file="/etc/lasthinker-release"
[[ -f "${lasthinker_release_file}" ]] && FDT_FILE="$(cat ${lasthinker_release_file} | grep -oE 'meson.*dtb')" || FDT_FILE=""

# Add custom enabled alias extension load module.
# For Tencent Aurora 3Pro (s905x3-b) box [ /etc/modprobe.d/blacklist.conf : blacklist btmtksdio ]
[[ "${FDT_FILE}" == "meson-sm1-skyworth-lb2004-a4091.dtb" ]] && modprobe btmtksdio 2>/dev/null

# Start ssh service
[[ -d "/var/run/sshd" ]] || mkdir -p -m0755 /var/run/sshd
[[ -f "/etc/init.d/ssh" ]] && /etc/init.d/ssh start 2>/dev/null

# Add custom log
echo "[$(date +"%Y.%m.%d.%H%M")] Hello World..." >/tmp/lasthinker_start_service.log
