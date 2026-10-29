#!/bin/bash
# Build dist/game-meta-guard-<version>.kwinscript (a zip of src/) for the KDE Store.
set -euo pipefail

root=$(cd "$(dirname "$0")/../.." && pwd)
version=$(grep -Po '"Version":\s*"\K[^"]+' "$root/src/metadata.json")
out="$root/dist/game-meta-guard-$version.kwinscript"

mkdir -p "$root/dist"
rm -f "$out"
(cd "$root/src" && bsdtar --format zip -cf "$out" metadata.json contents)
echo "$out"
