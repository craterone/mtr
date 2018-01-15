

build: bin
	crystal build src/mtr.cr -o ./bin/mtr

bin:
	mkdir bin