CC      = gcc
CFLAGS  = -O3 -Wall -ansi -pedantic -std=c99 -g

main: main.o
	$(CC) $(CFLAGS) -o main $<

main.o: main.c
	$(CC) $(CFLAGS) -c $<

clean:
	rm -f *.o main