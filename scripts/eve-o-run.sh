#!/bin/bash

set -eua pipefail

cd "$XDG_DATA_HOME"

. /app/constants.sh
cp /app/eve-o-preview.exe "$WINEPREFIX/eve-o-preview.exe"

# This is not in constants because it needs to be run after umu runs for the first time
PROTON_VERSION="$(cat $WINEPREFIX/version)"

"$UMU_PROTON_DIR/files/bin/wine64" "$WINEPREFIX/eve-o-preview.exe"
