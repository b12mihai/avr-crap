#include <avr/io.h>
#include <avr/interrupt.h>

#define F_CPU 16000000

#include <util/delay.h>
#include <stdlib.h>
#include <stdint.h>

uint8_t b0, b1, b2, b3, b4, b5;

void setup_bits(uint8_t bits)
{
	b0 = bits & 1;
	b1 = bits & 2;
	b2 = bits & 4;
	b3 = bits & 8;
	b4 = bits & 16;
	b5 = bits & 32;
}

void print_bargraph()
{
	PORTA = 0x00;
	if(b0) 
		PORTA |= 1;
	if(b1)
		PORTA |= (1 << 1);
	if(b2)
		PORTA |= (1 << 2);
	if(b3)
		PORTA |= (1 << 3);
	if(b4)
		PORTA |= (1 << 4);
	if(b5)
		PORTA |= (1 << 5);
}
	
int main()
{
	DDRA = 0xff;
	DDRC = 0x00;
	DDRD = 0xff;

	PORTA = 0x00;
	PORTD = 0x00;


	while(1) {
		setup_bits(PINC);
		print_bargraph();
		_delay_ms(100);
	}

	return 0;
}
