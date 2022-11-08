#!/usr/bin/env bash
# shellcheck disable=SC2034

iso_name="adk"
iso_label="adk-$(date +%Y.%m).01"
iso_publisher="ADK Linux <https://github.com/Technopig100>"
iso_application="ADK Linux Live/Rescue CD"
iso_version="$(date +%Y.%m).01"
install_dir="arch"
buildmodes=('iso')
bootmodes=('bios.syslinux.mbr' 'bios.syslinux.eltorito'
           'uefi-ia32.grub.esp' 'uefi-x64.grub.esp'
           'uefi-ia32.grub.eltorito' 'uefi-x64.grub.eltorito')
arch="x86_64"
pacman_conf="pacman.conf"
airootfs_image_type="squashfs"
airootfs_image_tool_options=('-comp' 'xz' '-Xbcj' 'x86' '-b' '1M' '-Xdict-size' '1M')
file_permissions=(
  ["/etc/gshadow"]="0:0:400"	
  ["/etc/shadow"]="0:0:400"
  ["/root"]="0:0:750"
  ["/etc/sudoers.d"]="0:0:750"
  ["/root/.automated_script.sh"]="0:0:755"
  ["/etc/polkit-1/rules.d"]="0:0:750"
  ["/usr/bin/calamares_polkit"]="0:0:755"
  ["/etc/xdg/autostart/calamares.desktop"]="0:0:644"
  ["/etc/sudoers.d"]="0:0:750"
  ["/usr/local/bin/choose-mirror"]="0:0:755"
  ["/usr/local/bin/Installation_guide"]="0:0:755"
  ["/usr/local/bin/livecd-sound"]="0:0:755"
  ["/usr/local/bin/adk-linux_rescue"]="0:0:755"
  ["/usr/local/bin/adk-before"]="0:0:755"
  ["/usr/local/bin/adk-final"]="0:0:755"
)
