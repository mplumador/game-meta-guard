NAME    := game-meta-guard
VERSION := $(shell grep -Po '"Version":\s*"\K[^"]+' src/metadata.json)
PREFIX  ?= /usr
DESTDIR ?=

SCRIPTDIR := $(DESTDIR)$(PREFIX)/share/kwin/scripts/$(NAME)

.PHONY: all kwinscript dist install clean

all: kwinscript dist

# KDE Store upload: dist/game-meta-guard-<version>.kwinscript
kwinscript:
	packaging/kde-store/build.sh

# Source tarball, as a GitHub release would produce it (used by the AUR PKGBUILD).
dist:
	mkdir -p dist
	tar -czf dist/$(NAME)-$(VERSION).tar.gz --exclude=./dist --exclude=./.git \
		--transform 's,^\.,$(NAME)-$(VERSION),' .

install:
	install -Dm644 src/metadata.json $(SCRIPTDIR)/metadata.json
	install -Dm644 src/contents/code/main.js $(SCRIPTDIR)/contents/code/main.js
	install -Dm644 src/contents/config/main.xml $(SCRIPTDIR)/contents/config/main.xml
	install -Dm644 src/contents/ui/config.ui $(SCRIPTDIR)/contents/ui/config.ui
	install -Dm755 tools/$(NAME)-setup $(DESTDIR)$(PREFIX)/bin/$(NAME)-setup
	install -Dm644 README.md $(DESTDIR)$(PREFIX)/share/doc/$(NAME)/README.md
	install -Dm644 LICENSE $(DESTDIR)$(PREFIX)/share/licenses/$(NAME)/LICENSE

clean:
	rm -rf dist
