#include <avr/io.h>
#include <avr/interrupt.h>

#define F_CPU 16000000

#include <util/delay.h>
#include <stdlib.h>
#include <stdint.h>

void setup_bits(uint8_t bits, uint8_t *b, uint8_t n)
{
	uint8_t i;

	for(i = 0; i < n; i++) {
		b[i] = bits & (1 << i);
	}
}

uint8_t print_bargraph(uint8_t *b)
{
	uint8_t output_bits = 0x00;

	if(b[0]) 
		output_bits |= 1;
	if(b[1])
		output_bits |= (1 << 1);
	if(b[2])
		output_bits |= (1 << 2);
	if(b[3])
		output_bits |= (1 << 3);
	if(b[4])
		output_bits |= (1 << 4);
	if(b[5])
		output_bits |= (1 << 5);
	return output_bits;
}
	
int main()
{
	DDRA = 0xff;
	DDRC = 0x00;
	DDRD = 0xff;

	PORTA = 0x00;
	PORTD = 0x00;

	uint8_t b[6];

	while(1) {
		setup_bits(PINC, b, 6);
		PORTA = print_bargraph(b);
		_delay_ms(100);
	}

	return 0;
}
