#include <avr/io.h>
#define F_CPU 16000000
#include <util/delay.h>

/* Close/open LED using button as input */

int main()
{
	/* PORT D pins are set as output */
	DDRD = 0b10000000;
	PORTD = 0xFF;

	while(1) {
	if((PIND & (1 << 6))) {
			PORTD |=  0b10000000;
		}
		else
			PORTD &= 0b01111111;
	}

	return 0;
}
