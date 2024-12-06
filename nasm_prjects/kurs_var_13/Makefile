FC=nasm
LR=ld
FFLAGS=-f elf64

all:
	$(FC) $(FFLAGS) src/main.asm -o obj/main.o
	$(LR) obj/main.o -o bin/app 

run:
	cd ./bin; ./app;

clean:
	rm -rf obj/*
	rm -rf bin/*
