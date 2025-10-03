#!/bin/sh

set -eua pipefail

cd "$XDG_DATA_HOME"

. /app/constants.sh
cp /app/eve-o-preview.exe "$WINEPREFIX/eve-o-preview.exe"

# This is not in constants because it needs to be run after umu runs for the first time
PROTON_VERSION="$(cat $WINEPREFIX/version)"

# For some reason this file needs to be created or dotnet fails to run
mkdir -p "$XDG_DATA_HOME/home/$USER/.cache/dotnet_bundle_extract"
"$XDG_DATA_HOME/../.local/share/Steam/compatibilitytools.d/$PROTON_VERSION/files/bin/wine64" "$WINEPREFIX/eve-o-preview.exe"
