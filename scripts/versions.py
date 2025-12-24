#!/usr/bin/env python3

import os
import urllib.request
import pprint


def sha256_file(url):
    import hashlib

    sha256 = hashlib.sha256()
    with urllib.request.urlopen(url) as response:
        while chunk := response.read(8192):
            sha256.update(chunk)
    return sha256.hexdigest()


versions = {
    "eve-o-preview": {
        "version_placeholder": "EVE_O_PREVIEW_VERSION",
        # renovate: datasource=github-releases depName=eve-o-preview packageName=proopai/eve-o-preview
        "version": "8.0.2.24",
        "url_template": "https://github.com/Proopai/eve-o-preview/releases/download/{version}/Release-{version}-Linux.zip",
    },
    "umu-launcher": {
        "version_placeholder": "UMU_LAUNCHER_VERSION",
        # renovate: datasource=github-tags depName=Open-Wine-Components/umu-launcher
        "version": "1.3.0",
        "url_template": "https://github.com/Open-Wine-Components/umu-launcher/releases/download/{version}/umu-launcher-{version}-zipapp.tar",
    },
}

cwd = os.getcwd()

with open(f"{cwd}/templates/com.eveonline.EveOnline.yml", "r") as f:
    data = f.read()
    for key, value in versions.items():
        data = data.replace(f"${{{value['version_placeholder']}}}", value["version"])
        sha256 = sha256_file(value["url_template"].format(version=value["version"]))
        data = data.replace(f"${{{value['version_placeholder'] + '_SHA256'}}}", sha256)
    with open(f"{cwd}/com.eveonline.EveOnline.yml", "w") as f:
        f.write(data)
