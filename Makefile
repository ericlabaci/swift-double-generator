prefix ?= /usr/local
bindir = $(prefix)/bin
libdir = $(prefix)/lib

build:
	swift build -c release --disable-sandbox

install: build
	mv .build/release/DoubleGenerator .build/release/double-generator
	install -d "$(bindir)" "$(libdir)"
	install ".build/release/double-generator" "$(bindir)"

uninstall:
	rm -rf "$(bindir)/double-generator"
	rm -rf "$(bindir)/swift-double-generator"

clean:
	rm -rf .build

.PHONY: build install uninstall clean

release:
	rm -rf ./GeneratorDouble
	swift build --configuration release
	cp -f .build/release/DoubleGenerator ./GeneratorDouble