VERSION := $(shell cat .version )
PLATFORM := $(shell uname -s | tr [A-Z] [a-z])

PROGNAME = amxx_game_master_menu.amxx
PROGNAME_VERSION = $(PROGNAME)-$(VERSION)
SOURCE_FILENAME = amxx_game_master_menu.sma
TARGZ_FILENAME = $(PROGNAME)-$(VERSION).tar.gz
TARGZ_CONTENTS = ${PROGNAME} README.md Makefile .version

PWD = $(shell pwd)

.PHONY: all version build clean install test

$(TARGZ_FILENAME):
	mkdir -vp "$(PROGNAME_VERSION)"
	cp -v $(TARGZ_CONTENTS) "$(PROGNAME_VERSION)/"
	tar -zvcf "$(TARGZ_FILENAME)" "$(PROGNAME_VERSION)"

$(PROGNAME):
	sed -i ".sed_original" -e "s/#define VERSION.*/#define VERSION \"${VERSION}\"/" "${SOURCE_FILENAME}"
	rm -v "${SOURCE_FILENAME}.sed_original"

test:
	@echo "Not implemented yet"

install:
	install -d $(DESTDIR)/usr/share/doc/$(PROGNAME_VERSION)
	install -d $(DESTDIR)/usr/bin
	install -m 755 $(PROGNAME) $(DESTDIR)/usr/bin
	install -m 644 README.md $(DESTDIR)/usr/share/doc/$(PROGNAME_VERSION)

clean:
	rm -vf "$(PROGNAME)"

build: $(PROGNAME)

compress: $(TARGZ_FILENAME)
