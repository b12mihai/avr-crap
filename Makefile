all: lab1.hex lab2.hex lab3.hex lab4.hex lab5.hex

lab1.elf: lab1.c	
	avr-gcc -mmcu=atmega16 -Os -Wall  -o lab1.elf lab1.c
lab2.elf: lab2.c
	avr-gcc -mmcu=atmega16 -Os -Wall  -o lab2.elf lab2.c
lab3.elf: lab3.c
	avr-gcc -mmcu=atmega16 -Os -Wall  -o lab3.elf lab3.c
lab4.elf: lab4.c
	avr-gcc -mmcu=atmega16 -Os -Wall  -o lab4.elf lab4.c
lab5.elf: lab5.c
	avr-gcc -mmcu=atmega16 -Os -Wall  -o lab5.elf lab5.c

lab1.hex: lab1.elf
	avr-objcopy  -j .text -j .data -O ihex  lab1.elf lab1.hex
	avr-size lab1.elf
lab2.hex: lab2.elf
	avr-objcopy  -j .text -j .data -O ihex  lab2.elf lab2.hex
	avr-size lab2.elf
lab3.hex: lab3.elf
	avr-objcopy  -j .text -j .data -O ihex  lab3.elf lab3.hex
	avr-size lab3.elf
lab4.hex: lab4.elf
	avr-objcopy  -j .text -j .data -O ihex  lab4.elf lab4.hex
	avr-size lab4.elf
lab5.hex: lab5.elf
	avr-objcopy  -j .text -j .data -O ihex  lab5.elf lab5.hex
	avr-size lab5.elf

clean:
	rm -rf *.elf *.hex
