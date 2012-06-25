all: adc.hex interrupt.hex onesecperiod.hex interrupt-when-overflow.hex pwm.hex

adc.elf: adc.c	
	avr-gcc -mmcu=atmega16 -Os -Wall  -o adc.elf adc.c

adc.hex: adc.elf
	avr-objcopy  -j .text -j .data -O ihex  adc.elf adc.hex
	avr-size adc.elf

interrupt.elf: interrupt.c	
	avr-gcc -mmcu=atmega16 -Os -Wall  -o interrupt.elf interrupt.c

interrupt.hex: interrupt.elf
	avr-objcopy  -j .text -j .data -O ihex  interrupt.elf interrupt.hex
	avr-size interrupt.elf
	
onesecperiod.elf: onesecperiod.c	
	avr-gcc -mmcu=atmega16 -Os -Wall  -o onesecperiod.elf onesecperiod.c

onesecperiod.hex: onesecperiod.elf
	avr-objcopy  -j .text -j .data -O ihex  onesecperiod.elf onesecperiod.hex
	avr-size onesecperiod.elf

interrupt-when-overflow.elf: interrupt-when-overflow.c	
	avr-gcc -mmcu=atmega16 -Os -Wall  -o interrupt-when-overflow.elf interrupt-when-overflow.c

interrupt-when-overflow.hex: interrupt-when-overflow.elf
	avr-objcopy  -j .text -j .data -O ihex  interrupt-when-overflow.elf interrupt-when-overflow.hex
	avr-size interrupt-when-overflow.elf

pwm.elf: pwm.c	
	avr-gcc -mmcu=atmega16 -Os -Wall  -o pwm.elf pwm.c

pwm.hex: pwm.elf
	avr-objcopy  -j .text -j .data -O ihex  pwm.elf pwm.hex
	avr-size pwm.elf


clean:
	rm -rf *.elf *.hex
