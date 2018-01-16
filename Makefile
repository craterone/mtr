

build: bin
	crystal build src/mtr.cr -o ./bin/mtr-online

bin:
	mkdir bin


install: release
	mv ./release/mtr-online /usr/bin/mtr-online

release:
	crystal build src/mtr.cr -o ./release/mtr-online --release --static

