#!/bin/sh

set -eua pipefail

cd "$XDG_DATA_HOME"

source /app/constants.sh
cp /app/eve-o-preview.exe "$XDG_DATA_HOME"/prefix/eve-o-preview.exe

# For some reason this file needs to be created or dotnet fails to run
mkdir -p "$XDG_DATA_HOME/home/$USER/.cache/dotnet_bundle_extract"

"$XDG_DATA_HOME"/proton/files/bin/wine64 "$XDG_DATA_HOME"/prefix/eve-o-preview.exe