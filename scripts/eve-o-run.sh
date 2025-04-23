#!/bin/sh

set -eua pipefail

# This is not in constants because it needs to be run after umu runs for the first time
PROTON_VERSION="$(cat "$XDG_DATA_HOME"/prefix/version)"

cd "$XDG_DATA_HOME"

. /app/constants.sh
cp /app/eve-o-preview.exe "$XDG_DATA_HOME"/prefix/eve-o-preview.exe

# For some reason this file needs to be created or dotnet fails to run
mkdir -p "$XDG_DATA_HOME/home/$USER/.cache/dotnet_bundle_extract"
"$XDG_DATA_HOME/../.local/share/Steam/compatibilitytools.d/$PROTON_VERSION/files/bin/wine64" "$XDG_DATA_HOME"/prefix/eve-o-preview.exe
