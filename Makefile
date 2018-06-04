CC		= nvcc
CFLAGS	= -O3 -Xptxas --opt-level=3 -arch sm_30 -g
LDFLAGS = -lm


main: main.o structure.o reduction.o
	$(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS)

main.o: main.cu structure.cu structure.h
	$(CC) $(CFLAGS) -c $<

structure.o: structure.cu structure.h
	$(CC) $(CFLAGS) -c $<

reduction.o: reduction.cu reduction.h
	$(CC) $(CFLAGS) -c $<

clean:
	rm -f *.o main