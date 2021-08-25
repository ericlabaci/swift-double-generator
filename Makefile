release:
	rm -rf ./DoubleGenerator
	swift build --configuration release
	cp -f .build/release/DoubleGenerator ./