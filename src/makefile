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
	clear
	gcc lex.yy.c ex1.tab.c -o $@ $(CFLAGS) -ly -lfl -std=c99
	./ex1.out < stringtest
clean:
	rm -rf *.o
mrproper: clean
	rm -rf ex1.out