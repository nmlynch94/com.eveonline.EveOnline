#!/bin/sh
export GAMEID="8500" # Steam ID of EVE Online
export WINEPREFIX="$XDG_DATA_HOME"/staging_prefix
 # At time of writing, fsync and esync cause cpu increases that never decrease
export PROTON_NO_FSYNC=1
export PROTON_NO_ESYNC=1
export PROTONPATH="GE-Proton"
export PROTON_VERB="run"

# Dotnet tries to create a directory, and I need to set this to avoid some weird wine path conversions that will create it in a non-existant dir.
export DOTNET_BUNDLE_EXTRACT_BASE_DIR=""
