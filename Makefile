CFLAGS = -Os -Wall
MMCU = atmega16
SRCS = $(wildcard *.c)
ELFS = $(patsubst %.c, %.elf, $(SRCS))
HEXS = $(patsubst %.c, %.hex, $(SRCS))

all: $(HEXS)
compile: $(ELFS)

%.elf: %.c
	avr-gcc -mmcu=$(MMCU) $(CFLAGS) -o $@ $<
%.hex: %.elf
	avr-objcopy -j .text -j .data -O ihex $< $@
	avr-size $<

.PHONY: clean all compile
clean:
	rm -rf *.elf *.hex *.swp *.swo *.o
