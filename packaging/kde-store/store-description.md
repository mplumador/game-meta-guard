Tapping the Meta (Windows) key opens the application launcher as usual — except while a game is focused, where it does nothing. No more accidentally popping the launcher mid-match. Alt+Tab, Meta+<key> combos and all other global shortcuts keep working.

Games are detected by window class: anything starting with steam_app_ (Steam/Proton) plus gamescope. Use the script's settings (gear icon) to add more window classes, or to treat any fullscreen window as a game (with browsers and video players excluded by default).

SETUP (required — Plasma won't hand the Meta key to a script automatically):
1. Enable the script here and click Apply.
2. System Settings → Keyboard → Shortcuts → Plasma → Activate Application Launcher: remove Meta, keep Alt+F1. Apply.
3. System Settings → Keyboard → Shortcuts → KWin → Game Meta Guard: set it to Meta. Apply.

UNINSTALL: first clear the Game Meta Guard shortcut and add Meta back to Activate Application Launcher, otherwise tapping Meta will do nothing.

Arch users: the AUR package kwin-scripts-game-meta-guard includes a game-meta-guard-setup command that does the rebinding for you.
