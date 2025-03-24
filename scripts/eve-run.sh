#!/bin/sh
set -ex

cd "$XDG_DATA_HOME"

winebin="/app/opt/wine/bin"
eve_online_setup_exe_url="https://launcher.ccpgames.com/eve-online/release/win32/x64/eve-online-latest+Setup.exe"
eve_online_installer_name="eve-online-setup.exe"

export WINEPREFIX="$XDG_DATA_HOME"/prefix
jagex_launcher_exe_path="$WINEPREFIX/drive_c/users/steamuser/AppData/Local/eve-online/eve-online.exe"

export GAMEID="8500" # Steam ID of EVE Online
export PROTON_NO_ESYNC=1
export PROTON_NO_FSYNC=1 
export PROTONPATH="$XDG_DATA_HOME/proton"

# Install if the eve-online exe does not exist
if ! [ -f "$jagex_launcher_exe_path" ]; then
    echo "First time install"
    curl -o "proton.tar.gz" -L "https://github.com/GloriousEggroll/proton-ge-custom/releases/download/GE-Proton9-26/GE-Proton9-26.tar.gz"
    mkdir proton
    tar -xzf "proton.tar.gz" -C proton --strip-components=1
    umu-run winetricks -q dotnet8
    curl -o "$eve_online_installer_name" -L "$eve_online_setup_exe_url"
    WINE_NO_PRIV_ELEVATION=1 umu-run "$eve_online_installer_name"
    rm "$eve_online_installer_name"
    exit 0 # Prevent running twice after first installation
fi

echo "Game installation detected. Running now..."
umu-run "$jagex_launcher_exe_path"