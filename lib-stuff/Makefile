main.hex: main.elf
	avr-objcopy  -j .text -j .data -O ihex main.elf main.hex
	avr-size main.elf

main.elf: utils.c main.c utils.h
	avr-gcc -mmcu=atmega16 -Os -Wall -o main.elf utils.c main.c

clean:
	rm -f *.elf *.hex

.PHONY: clean