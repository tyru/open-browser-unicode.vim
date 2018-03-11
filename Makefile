
release:
	git archive HEAD plugin doc --output=open-browser-unicode-$(shell git describe --tags HEAD).zip

.PHONY: release
