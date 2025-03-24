#!/bin/bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
EVE_O_EXE_NAME="EVE-O-Preview.exe"
EVE_EXE_NAME="Eve-Launcher.exe"

curl -L "https://launcher.ccpgames.com/eve-online/release/win32/x64/eve-online-latest+Setup.exe" -o "$EVE_EXE_NAME"
curl -L "https://github.com/Proopai/eve-o-preview/releases/download/8.0.2.0/Release-8.0.2.0-Linux.zip" -o "$EVE_O_EXE_NAME".zip

unzip -j "$EVE_O_EXE_NAME".zip

wrestool -x --output=eve-icon.ico -t14 "$EVE_EXE_NAME"
convert eve-icon.ico eve-icon.png
wrestool -x --output=eve-o-icon.ico -t14 "$EVE_O_EXE_NAME"
convert eve-o-icon.ico eve-o-icon.png

mkdir -p 256
convert eve-icon-1.png -resize 256x256 256/eve-256.png
convert eve-o-icon-2.png -resize 256x256 256/eve-o-256.png

# Cleanup
# ls -p | grep -v / | grep -v "extract_icons.sh" | xargs -n1 rm
# rm -r locales