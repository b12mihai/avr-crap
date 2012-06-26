#include <avr/io.h>
#include <avr/interrupt.h>

#define F_CPU 16000000

#include <util/delay.h>
#include <stdlib.h>
#include <stdint.h>

int main()
{
	DDRD = 0xff;
	PORTD = 0x00;

	DDRA = 0x00;
	PORTA = 0x00;
	uint8_t b0, b1, b2, b3, b4, b5, b6;

	while(1) {
		b0 = PINA & 1;
		b1 = PINA & (1 << 1);
		b2 = PINA & (1 << 2);
		b3 = PINA & (1 << 3);
		b4 = PINA & (1 << 4);
		b5 = PINA & (1 << 5);
		b6 = PINA & (1 << 6);

		if(!b0 && !b1 && b2 && b3 && b4 && !b5 && !b6) {
			PORTD = 0xff;
		}

		PORTD = 0x00;

	}

	return 0;
}
