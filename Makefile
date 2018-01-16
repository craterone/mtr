

build: bin
	crystal build src/mtr.cr -o ./bin/mtr-online

bin:
	mkdir bin


install: build
	mv ./bin/mtr-online /usr/bin/mtr-online