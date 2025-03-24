#!/bin/sh
cd "$XDG_DATA_HOME"

export WINEPREFIX="$XDG_DATA_HOME"/prefix
cp "/app/eve-o-preview.exe" "$WINEPREFIX/eve-o-preview.exe"

# For some reason this file needs to be created or dotnet fails to run
mkdir -p "$XDG_DATA_HOME/home/$USER/.cache/dotnet_bundle_extract"

# We run wine directly because running proton does not allow two processes to launch in the same prefix
WINEPREFIX="$(pwd)/prefix" ./proton/files/bin/wine64 ./prefix/eve-o-preview.exe
