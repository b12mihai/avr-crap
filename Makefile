all: adc.hex 

adc.elf: adc.c	
	avr-gcc -mmcu=atmega16 -Os -Wall  -o adc.elf adc.c

adc.hex: adc.elf
	avr-objcopy  -j .text -j .data -O ihex  adc.elf adc.hex
	avr-size adc.elf
	
burn-adc:
	gksu avrusbbootloader/software/avrusbboot adc.hex

clean:
	rm -rf *.elf *.hex
