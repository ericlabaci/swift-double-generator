release:
	rm -rf ./GeneratorDouble
	swift build --configuration release
	cp -f .build/release/DoubleGenerator ./GeneratorDouble