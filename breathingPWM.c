#include <avr/io.h>
#include <avr/interrupt.h>

#define F_CPU 16000000

#include <util/delay.h>
#include <stdlib.h>
#include <stdint.h>

/* 
 * Breathing LED effect using PWM and hardware timers 
 * Use PWM Phase Correct with Timer/Counter Control Register 2 
 */

int main()
{
	TCCR2 = 0;
	
	/* Register bits are set to obtain Phase Correct PWM */
	TCCR2 |= (1 << WGM20) | (1 << CS22) |
			(1 << CS20) | (1 << COM21);
	
	uint8_t i;

	while(1) {
		/* Incrementally increase light */
		for(i = 0; i < 255; ++i) {
			OCR2 = i;
			_delay_ms(10);
		}

		/* Stay on for half a second */
		_delay_ms(500);
		
		/* Dim light */
		for(i = 255; i > 0; --i) {
			OCR2 = i;
			_delay_ms(10);
		}
	}

	return 0;
}
