CC=gcc
CFLAGS= `pkg-config --cflags --libs cairo`

%.out: %.c
	$(CC) -o $@ $(CFLAGS) $<