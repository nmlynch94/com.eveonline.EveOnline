#!/bin/sh
export GAMEID="8500" # Steam ID of EVE Online
export WINEPREFIX="$XDG_DATA_HOME"/prefix
export PROTON_NO_FSYNC=1
export PROTON_NO_ESYNC=1
export PROTONPATH="$XDG_DATA_HOME/proton"

export PROTON_LATEST_URL="https://github.com/GloriousEggroll/proton-ge-custom/releases/download/GE-Proton9-26/GE-Proton9-26.tar.gz"
export PROTON_LATEST_SHA512="6589a3d5561948f738f59309c93953f1e74a282f4945077188ee866c517e8a2d8196715f484b8e1097964962f3ec047e22da2012df25e81238a96d25d3285091"