CFLAGS = -Isrc/include -Isrc/RMQ

all: 
		g++ $(CFLAGS) -std=c++11 -O3 -fomit-frame-pointer -fprefetch-loop-arrays -DNDEBUG src/parser.cpp src/kmacs.cpp src/run.cpp src/sais.c -o kmacs_ld 
