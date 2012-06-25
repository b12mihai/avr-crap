#include <avr/io.h>
#include <avr/interrupt.h>

#define F_CPU 16000000

#include <util/delay.h>
#include <stdlib.h>
#include <stdint.h>

int main()
{
	TCCR0 |= (1 << WGM00) | (1 << COM01) | (1 << WGM01) | (1 << CS00); /* f =~ 65kHz */
	OCR0 = 200;
	
	while(1); 	
	return 0;
}
