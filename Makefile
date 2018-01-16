

build: bin
	crystal build src/mtr.cr -o ./bin/mtr-online

bin:
	mkdir bin


install: static-release
	cp ./release/mtr-online /usr/bin/mtr-online

static-release:
	crystal build src/mtr.cr -o ./release/mtr-online --release --static

