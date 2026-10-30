# KDE Store release

1. Bump `Version` in `src/metadata.json`.
2. `make kwinscript` → `dist/game-meta-guard-<version>.kwinscript`.
3. Test it locally:
   ```sh
   kpackagetool6 --type KWin/Script -i dist/game-meta-guard-<version>.kwinscript   # first time
   kpackagetool6 --type KWin/Script -u dist/game-meta-guard-<version>.kwinscript   # upgrade
   ```
4. Upload at <https://store.kde.org> → Add Product → category **KWin Scripts**.
   Paste `store-description.md` into the description field and use `logo.png` as the logo
   (regenerate with `rsvg-convert -w 256 -h 256 logo.svg -o logo.png` after editing `logo.svg`).
