#!/bin/sh
cd "$XDG_DATA_HOME"

export GAMEID="8500" # Steam ID of EVE Online
export WINEPREFIX="$XDG_DATA_HOME"/prefix
cp "/app/eve-o-preview.exe" "$WINEPREFIX/eve-o-preview.exe"

# For some reason this file needs to be created or dotnet fails to run
mkdir -p "$XDG_DATA_HOME/home/$USER/.cache/dotnet_bundle_extract"

# We run wine directly because running proton does not allow two processes to launch in the same prefix
# Even using proton_verb=runinprefix from umu results in eve-o running, but it cannot properly interact with game windows.
"$XDG_DATA_HOME"/proton/files/bin/wine64 "$XDG_DATA_HOME"/prefix/eve-o-preview.exe