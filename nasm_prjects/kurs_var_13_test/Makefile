FC=nasm
LR=gcc
FFLAGS=-f elf64
LFLAGS=-static

all:
	$(FC) $(FFLAGS) src/main.asm -o obj/main.o
	$(LR) obj/main.o ${LFLAGS} -o bin/app 

run:
	cd ./bin; ./app;

clean:
	rm -rf obj/*
	rm -rf bin/*
