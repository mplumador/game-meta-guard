# Game Meta Guard

A KWin script for KDE Plasma 6 that makes the Meta (Windows) key behave like it does on Windows
while gaming: tapping Meta opens the application launcher as usual, **except while a game window
is focused**, where it does nothing. Alt+Tab, Meta+<key> combos and every other global shortcut
keep working.

## Why

Brushing the Meta key mid-game pops the application launcher over the game, steals focus and
often minimizes or drops a fullscreen game out of fullscreen. The usual fixes trade one problem for
another:

- **Disable the Meta key entirely.** No more accidental launchers, but also no launcher on a Meta
  tap anywhere else on the desktop, which is the whole point of the key.
- **Set *Ignore global shortcuts* on the game with a KWin window rule.** Meta stops opening the
  launcher, but so does everything else: Alt+Tab, volume and media keys, screenshot shortcuts and
  every other global binding stop working while the game is focused.

Game Meta Guard only blocks the bare Meta tap, and only while a game is focused. Everything else
behaves exactly as it does without it.

## Which windows count as games

A window counts as a game if:

- its window class starts with `steam_app_` (always on; Proton sets this for Steam games, and for
  Heroic/Lutris games run through Proton via umu, e.g. `steam_app_0` or `steam_app_default`), or
- its class is in **Also treat as games** (default: `gamescope`), or
- **Treat any fullscreen window as a game** is enabled (off by default), it is fullscreen, and its
  class is not in **Except these** (browsers and video players by default).

Configure these from the gear icon next to the script in
**System Settings → Window Management → KWin Scripts**. Lists are comma separated window classes;
end an entry with `*` to match a prefix.

## How it works

Plasma binds a bare Meta tap to *Activate Application Launcher*. Game Meta Guard registers its own
global shortcut, which you bind to Meta instead. When it fires, it checks the focused window and
only triggers *Activate Application Launcher* if that window is not a game.

## Install

### Arch Linux

An AUR package is coming once AUR account registration reopens. Until then, build the package
from this repository:

```sh
git clone https://github.com/mplumador/game-meta-guard.git
cd game-meta-guard/packaging/aur
makepkg -si
game-meta-guard-setup enable
```

Or download the pre-built `kwin-scripts-game-meta-guard-<version>-1-any.pkg.tar.zst` from
[Releases](https://github.com/mplumador/game-meta-guard/releases) and install it with
`sudo pacman -U <file>`.

`game-meta-guard-setup` enables the script and moves the Meta binding for you.
`game-meta-guard-setup status` shows the current bindings.

### KDE Store

1. **System Settings → Window Management → KWin Scripts → Get New…**, install
   **Game Meta Guard**, tick it and click **Apply**.
2. **System Settings → Keyboard → Shortcuts → Plasma → Activate Application Launcher**:
   remove `Meta`, keep `Alt+F1`. Apply.
3. **System Settings → Keyboard → Shortcuts → KWin → Game Meta Guard**: set it to `Meta`
   (press and release the Windows key while recording). Apply.

## Uninstall

Put Meta back on the launcher **before** removing the script, or tapping Meta will do nothing.

- Arch package: run `game-meta-guard-setup disable`, then `sudo pacman -R kwin-scripts-game-meta-guard`.
- KDE Store: clear the *Game Meta Guard* shortcut, add `Meta` back to *Activate Application
  Launcher*, then untick/remove the script.

## Adding a game that isn't detected

Find its window class with `qdbus6 org.kde.KWin /KWin queryWindowInfo` (then click the game
window) and add its `resourceClass` to **Also treat as games** in the script's settings.
Alternatively, enable **Treat any fullscreen window as a game**.

## Building

```sh
make kwinscript   # dist/game-meta-guard-<version>.kwinscript for the KDE Store
make dist         # dist/game-meta-guard-<version>.tar.gz source tarball
```

See `packaging/kde-store/` and `packaging/aur/` for release steps.
