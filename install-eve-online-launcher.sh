#!/bin/bash
FREEDESKTOP_VERSION="23.08"

set -e

HAS_NVIDIA=0
if [[ -f /proc/driver/nvidia/version ]]; then
  HAS_NVIDIA=1
  NVIDIA_VERISON=$(cat /proc/driver/nvidia/version | head -n 1 | awk '{ print $8 }' | sed 's/\./-/g')
fi

flatpak remote-add --user --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# https://github.com/flatpak/flatpak/issues/3094
flatpak install --user -y --noninteractive flathub \
  org.freedesktop.Platform//${FREEDESKTOP_VERSION} \
  org.freedesktop.Platform.Compat.i386/x86_64/${FREEDESKTOP_VERSION} \
  org.freedesktop.Platform.GL32.default/x86_64/${FREEDESKTOP_VERSION}

if [[ ${HAS_NVIDIA} -eq 1 ]]; then
  flatpak install --user -y --noninteractive flathub \
    org.freedesktop.Platform.GL.nvidia-${NVIDIA_VERISON}/x86_64 \
    org.freedesktop.Platform.GL32.nvidia-${NVIDIA_VERISON}/x86_64
fi

curl -L https://github.com/nmlynch94/com.eveonline.EveOnline/releases/latest/download/com.eveonline.EveOnline.flatpak >com.eveonline.EveOnline.flatpak
echo "Installing......."
flatpak install -y --user --noninteractive com.eveonline.EveOnline.flatpak
flatpak run com.eveonline.EveOnline
rm com.eveonline.EveOnline.flatpak
echo "DONE"
