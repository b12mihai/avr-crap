#include<avr/io.h>
#include<avr/interrupt.h>

#define F_CPU 16000000

#include<util/delay.h>
#include <stdlib.h>
#include<stdint.h>

int main()
{
	/* TCCR1A has output on port D */
	DDRD = 0xFF;

	/* Fast PWM using TCCR1A register */
	TCCR1A |= (1 << WGM10) | (1 << COM1A1) | (1 << COM1B1);
	TCCR1B |= (1 << WGM12) | (1 << CS10) ;
	
	/* Initialize duty cycles */
	OCR1A = 0;
	OCR1B = 255;
	
	/* Make PWMs in antiphase */
	while(1) {
		OCR1A++;
		OCR1B--;
		_delay_ms(50);
	}
	
	return 0;
}
