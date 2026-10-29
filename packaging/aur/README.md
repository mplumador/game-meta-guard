# AUR release

The PKGBUILD builds from a tagged GitHub release tarball and installs with `make install`.

## Test locally

```sh
packaging/aur/test-local.sh        # builds dist/aur-build/*.pkg.tar.zst
packaging/aur/test-local.sh -i     # build and install
```

## Publish

1. Replace the `CHANGEME` placeholders in `PKGBUILD` (maintainer email, repo URL) and in
   `src/metadata.json` (`Website`).
2. Tag and push the release: `git tag v<version> && git push --tags`.
3. In this directory: `updpkgsums && makepkg --printsrcinfo > .SRCINFO`.
4. First time: `git clone ssh://aur@aur.archlinux.org/kwin-scripts-game-meta-guard.git`
   (needs an AUR account with your SSH key).
5. Copy `PKGBUILD`, `kwin-scripts-game-meta-guard.install` and `.SRCINFO` into that clone,
   commit and push.

For later releases bump `pkgver` (reset `pkgrel=1`) and repeat steps 2–5.
