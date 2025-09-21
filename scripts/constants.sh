#!/bin/sh
export GAMEID="8500" # Steam ID of EVE Online
export WINEPREFIX="$XDG_DATA_HOME"/prefix
 # At time of writing, fsync and esync cause cpu increases that never decrease
export PROTON_NO_FSYNC=1
export PROTON_NO_ESYNC=1
export PROTONPATH="UMU-Latest"
