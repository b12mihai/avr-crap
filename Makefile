all: adc.hex interrupt.hex

adc.elf: adc.c	
	avr-gcc -mmcu=atmega16 -Os -Wall  -o adc.elf adc.c

adc.hex: adc.elf
	avr-objcopy  -j .text -j .data -O ihex  adc.elf adc.hex
	avr-size adc.elf
	
burn-adc:
	gksu ./avrusbbootloader/software/avrusbboot adc.hex

interrupt.elf: interrupt.c	
	avr-gcc -mmcu=atmega16 -Os -Wall  -o interrupt.elf interrupt.c

interrupt.hex: interrupt.elf
	avr-objcopy  -j .text -j .data -O ihex  interrupt.elf interrupt.hex
	avr-size interrupt.elf
	
burn-interrupt:
	gksu ./avrusbbootloader/software/avrusbboot interrupt.hex

clean:
	rm -rf *.elf *.hex
