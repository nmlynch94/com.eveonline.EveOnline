#!/bin/bash
set -euo pipefail

cd icons
./extract_icons.sh
cd ..

flatpak remote-add --if-not-exists --user flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak-builder --repo=out --default-branch=stable --gpg-sign=7F8984DD7137F9C3E145D3872A6DA56948125AE2 --require-changes --rebuild-on-sdk-change --install --install-deps-from=flathub --user --ccache --force-clean build-dir com.eveonline.EveOnline.yml
flatpak build-update-repo --gpg-sign=7F8984DD7137F9C3E145D3872A6DA56948125AE2 out --title="EVE Online Launcher" --generate-static-deltas --default-branch=stable --prune
