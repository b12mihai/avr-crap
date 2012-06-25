#include <avr/io.h>
#include <avr/interrupt.h>

#define F_CPU 16000000

#include <util/delay.h>
#include <stdlib.h>
#include <stdint.h>

int main()
{
	/* Fast PWM using Timer Counter Control Register 0 */
	
	TCCR0 |= (1 << WGM00) | (1 << COM01) | (1 << WGM01) | (1 << CS00);
	
	OCR0 = 0;
	
	/* OCR0 is duty cycle, let's increase it */
	while(1) {
		OCR0++;
		_delay_ms(50);
	}
	
	return 0;
}
