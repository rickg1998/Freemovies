#!/usr/bin/env bash
set -euo pipefail
python - <<'PY'
from pathlib import Path
import hashlib
import zipfile
archive = Path("RGShows-metadata-service.zip")
expected = "436d9a41bf8b64dd919837d2e6e71d67da9f14a1ac8ee7846c2909d97ea720cf"
if hashlib.sha256(archive.read_bytes()).hexdigest() != expected:
    raise SystemExit("Metadata service package checksum differs; review the updated package and refresh the deployment checksum.")
root = Path.cwd().resolve()
with zipfile.ZipFile(archive) as bundle:
    for member in bundle.namelist():
        if not (root / member).resolve().is_relative_to(root):
            raise SystemExit("Unsafe archive path")
    bundle.extractall(root)
PY
python -m pip install --disable-pip-version-check -r rgshows-metadata/requirements.lock

