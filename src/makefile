CC=gcc
CFLAGS= `pkg-config --cflags --libs cairo`
EXEC = ex1.out
run: $(EXEC)

%.tab.c %.tab.h: %.y
	bison -dv $<
%.yy.c: %.lex %.tab.h
	flex -o $@ $<
%.yy.o: %%.yy.c
	gcc -c -o $@ $<
%.tab.o: %.tab.c
	gcc -c -o $@ $<
%.out: %.yy.o %.tab.o
	gcc -Wall -g -o $@ $^ $(CFLAGS) -ly -lfl -std=c99

clean:
	rm -rf *.o
mrproper: clean
	rm -rf ex1.out