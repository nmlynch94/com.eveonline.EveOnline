#!/bin/bash

set -eua pipefail

cd "$XDG_DATA_HOME"

. /app/constants.sh
cp /app/eve-o-preview.exe "$WINEPREFIX/eve-o-preview.exe"

# Running this using the full umu-run command causes eve-o to regularly hang
"$UMU_PROTON_DIR/files/bin/wine64" "$WINEPREFIX/eve-o-preview.exe"
