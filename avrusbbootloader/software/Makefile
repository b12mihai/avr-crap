LIBUSB_CONFIG   = libusb-config
CFLAGS =-g -Wall -pedantic
LFLAGS =-lusb

all: avrusbboot

clean:
	rm *.o
	rm avrusbboot

avrusbboot: main.cpp cflashmem.o cpage.o cbootloader.o
	cl $(CFLAGS) main.cpp cflashmem.o cpage.o cbootloader.o -o avrusbboot $(LFLAGS)
