#!/usr/bin/env python3

import os

versions = {
    # renovate: datasource=github-tags depName=proopai/eve-o-preview
    "EVE_O_PREVIEW_VERSION": "8.0.2.1",
    "EVE_O_PREVIEW_SHA256": "118091b9668c39e4b23a1c7d26b6fb024a71753d6bf0f0ff44f30f746065e4cb",
    # renovate: datasource=github-tags depName=Open-Wine-Components/umu-launcher
    "UMU_LAUNCHER_VERSION": "1.2.6",
    "UMU_LAUNCHER_SHA256": "ae0bfd9bd3de209d0b6590ffbffc395d79c501b10176e9e239e4a1f842b4ad3a",
}

cwd = os.getcwd()

with open(f"{cwd}/templates/com.eveonline.EveOnline.yml", "r") as f:
    data = f.read()
    for key, value in versions.items():
        data = data.replace(f"${{{key}}}", value)
    with open(f"{cwd}/templates/com.eveonline.EveOnline.yml", "w") as f:
        f.write(data)
