#!/bin/sh
set -eua pipefail

cd "$XDG_DATA_HOME"
source /app/constants.sh

eve_online_setup_exe_url="https://launcher.ccpgames.com/eve-online/release/win32/x64/eve-online-latest+Setup.exe"
eve_online_installer_name="eve-online-setup.exe"

eve_launcher_exe_path="$WINEPREFIX/drive_c/users/steamuser/AppData/Local/eve-online/eve-online.exe"

# Install if the eve-online exe does not exist
if ! [ -f "$eve_launcher_exe_path" ]; then
  # Install dotnet8 and launch
  umu-run winetricks -q dotnet8
  curl -o "$eve_online_installer_name" -L "$eve_online_setup_exe_url"
  WINE_NO_PRIV_ELEVATION=1 umu-run "$eve_online_installer_name"
  rm "$eve_online_installer_name"
  exit 0 # Prevent running twice after first installation
fi

echo "Game installation detected. Running now..."
umu-run "$eve_launcher_exe_path"
