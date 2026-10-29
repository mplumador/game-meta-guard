// Bound to a bare Meta tap in kglobalaccel (System Settings > Shortcuts > KWin).
// Opens the launcher unless the focused window looks like a game.

// Keep in sync with contents/config/main.xml
const DEFAULT_EXTRA = "gamescope";
const DEFAULT_EXCLUDE = "firefox, librewolf, google-chrome, chromium, brave-browser, vivaldi-stable, " +
    "microsoft-edge, mpv, vlc, org.kde.haruna, smplayer, io.github.celluloid_player.celluloid, " +
    "org.gnome.totem, kodi, freetube, org.kde.okular, libreoffice*";

let extraGameClasses = [];
let fullscreenIsGame = false;
let fullscreenExclude = [];

function classList(key, fallback) {
    return String(readConfig(key, fallback)).toLowerCase().split(",")
        .map(s => s.trim()).filter(s => s.length > 0);
}

// "foo" matches exactly, "foo*" matches as a prefix.
function matches(cls, patterns) {
    return patterns.some(p => p.endsWith("*") ? cls.startsWith(p.slice(0, -1)) : cls === p);
}

function loadConfig() {
    extraGameClasses = classList("ExtraGameClasses", DEFAULT_EXTRA);
    fullscreenIsGame = String(readConfig("FullscreenIsGame", false)) === "true";
    fullscreenExclude = classList("FullscreenExclude", DEFAULT_EXCLUDE);
}

function isGame(w) {
    if (!w) return false;
    const cls = String(w.resourceClass).toLowerCase();
    if (cls.startsWith("steam_app_") || matches(cls, extraGameClasses)) return true;
    return fullscreenIsGame && w.fullScreen && !matches(cls, fullscreenExclude);
}

loadConfig();
options.configChanged.connect(loadConfig);

registerShortcut("Game Meta Guard", "Game Meta Guard: launcher unless a game is focused", "Meta", function () {
    if (isGame(workspace.activeWindow)) return;
    callDBus("org.kde.kglobalaccel", "/component/plasmashell", "org.kde.kglobalaccel.Component",
             "invokeShortcut", "activate application launcher");
});
