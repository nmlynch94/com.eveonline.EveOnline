#!/bin/sh
# Steam ID of EVE Online
export GAMEID="8500"
export WINEPREFIX="$XDG_DATA_HOME"/staging_prefix

 # At time of writing, fsync and esync cause resource leaks that increase CPU usage and cause crashes
export PROTON_NO_FSYNC=1
export PROTON_NO_ESYNC=1

# The umu_proton_dir and protonpath need to be different because umu_proton_dir is from the flatpak sandbox perspective, while protonpath is from the steam runtime perspective.
export UMU_PROTON_DIR="$HOME/.var/app/com.eveonline.EveOnline/.local/share/umu/proton-eve-bundled/proton"
export PROTONPATH="$HOME/.local/share/umu/proton-eve-bundled/proton"

# Allow re-running the eve launcher after closing. Otherwise, proton will just block until all currently running processes are closed
export PROTON_VERB="run"


# Dotnet tries to create a directory, and I need to set this to avoid some weird wine path conversions that will create it in a non-existant dir.
export DOTNET_BUNDLE_EXTRACT_BASE_DIR=""
