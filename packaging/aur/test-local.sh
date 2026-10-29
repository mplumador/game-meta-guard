#!/bin/bash
# Build the AUR package from the working tree instead of a GitHub release.
# Usage: packaging/aur/test-local.sh [extra makepkg args, e.g. -i]
set -euo pipefail

here=$(cd "$(dirname "$0")" && pwd)
root=$(cd "$here/../.." && pwd)
version=$(grep -Po '"Version":\s*"\K[^"]+' "$root/src/metadata.json")
build="$root/dist/aur-build"

make -C "$root" dist
rm -rf "$build" && mkdir -p "$build"
cp "$root/dist/game-meta-guard-$version.tar.gz" "$here/kwin-scripts-game-meta-guard.install" "$build/"
sed -e "s/^pkgver=.*/pkgver=$version/" \
    -e 's|^source=.*|source=("$_name-$pkgver.tar.gz")|' \
    "$here/PKGBUILD" > "$build/PKGBUILD"
(cd "$build" && makepkg -f "$@")
