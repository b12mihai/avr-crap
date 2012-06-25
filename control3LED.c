#include <avr/io.h>
#define F_CPU 16000000
#include<util/delay.h>
#include<stdint.h>

/* Control 3 LEDS using switch */

int main()
{
	DDRA = 0xFF;
	uint8_t i = 0;
	uint8_t citit = 0;

	PORTD = 0xFF;
	PORTA = 0x00;

	while(1) {

		citit = 0;

		if(~(PIND & (1 << 6))) {
			++i;
			citit = 1;
		} 

		if(citit) {

			/* Open LED from specific port */
			if(i == 1) {
				PORTA = 0b00100000;
				_delay_ms(500);
			} 
			else if(i == 2) {
				PORTA = 0b01000000;
				_delay_ms(500);
			}
			else if(i == 3) {
				PORTA = 0b10000000;
				_delay_ms(500);
			}
		}

		if(i == 3)
			i = 0;

	}

	return 0;
}
