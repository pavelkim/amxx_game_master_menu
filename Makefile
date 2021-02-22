VERSION := $(shell cat .version )
PLATFORM := $(shell uname -s | tr [A-Z] [a-z])
PWD = $(shell pwd)

PROGNAME = amxx_game_master_menu.amxx
PROGNAME_VERSION = $(PROGNAME)-$(VERSION)
SOURCE_FILENAME = amxx_game_master_menu.sma
TARGZ_FILENAME = $(PROGNAME)-$(VERSION).tar.gz
TARGZ_CONTENTS = ${PROGNAME} README.md Makefile .version
LOGFILE = "${PROGNAME_VERSION}-build.log"

PLUGIN_COMPILER = "build/linux/amxxpc"

.PHONY: all version build clean install test

$(TARGZ_FILENAME):
	mkdir -vp "$(PROGNAME_VERSION)"
	cp -v $(TARGZ_CONTENTS) "$(PROGNAME_VERSION)/"
	tar -zvcf "$(TARGZ_FILENAME)" "$(PROGNAME_VERSION)"

$(PROGNAME):
	sed -i ".sed_original" -e "s/#define VERSION.*/#define VERSION \"${VERSION}\"/" ${SOURCE_FILENAME}
	rm -v "${SOURCE_FILENAME}.sed_original"
	${PLUGIN_COMPILER} "${SOURCE_FILENAME}" "-o${PROGNAME}" | tee ${LOGFILE}

test:
	@echo "Not implemented yet"

install:
	@echo "Not implemented yet"

clean:
	rm -vf "$(PROGNAME)"
	rm -vf "$(TARGZ_FILENAME)"

build: $(PROGNAME)

compress: $(TARGZ_FILENAME)
