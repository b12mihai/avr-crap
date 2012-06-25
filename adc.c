#include <avr/io.h>
#include <avr/interrupt.h>

#define F_CPU 16000000

#include <util/delay.h>
#include <stdlib.h>
#include <stdint.h>

int main()
{
	/* Ouput for OCR2 - pin D7 for led */
	DDRD = 0xFF;
	
	uint8_t x;
	
	/* Configure Analog to Digital Converter */
	ADMUX |= (1 << REFS0);
	ADCSRA |= (1 << ADEN) | (1 << ADPS2) | (1 << ADPS1) | (1 << ADPS0);
	
	/* adjust result to left (if this is 0, LED is blinking 4 times at 
	 * correct reading) */
	ADMUX |= (1 << ADLAR);
	
	/* Configure PWM for checking correctness of reading */
	TCCR2 |= (1 << WGM20) | (1 << CS22) | (1 << CS20) | (1 << COM21);
	
	while(1) {
		ADCSRA |= (1 << ADSC);
		while(!(ADCSRA & (1 << ADIF)));
		
		/* Set IF to 1 to read further */
		ADCSRA |= (1 << ADIF);
		
		/* Save data. From datasheet: 
		 * When ADCL is read, the ADC Data Register is not updated until ADCH is read. Consequently, if
		 * the result is left adjusted and no more than 8-bit precision is required, it is sufficient to read
		 * ADCH. Otherwise, __ADCL must be read first, then ADCH__
		 */
		x = ADCL;
		OCR2 = ADCH; /* If analog reading is correct, a LED should be open! */
		
	}
	
	
	return 0;
}
