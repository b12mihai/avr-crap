#include <avr/io.h>
#include <avr/interrupt.h>
#define F_CPU 16000000

/* Basically, this code should make the LED from port D blink at every 1 sec */

ISR(TIMER1_COMPA_vect)
{
	TCNT1 = 0;
	/* Reverse PORTD at every 1 second */
	PORTD ^= 0xff;
}

int main()
{
	DDRD = 0xff;
	PORTD = 0xff;
	
	/* Maximum value for prescaler */
	OCR1A = 16000;

	/* Initialize timers */
	TCCR1A = 0x00;
	TCCR1B |= (1 << WGM12) | (1 << CS10) | (1 << CS12);
	
	/* enable comparison between Timer Counter (TCNT)
	 * and Output Compare Register (OCR) 
	 */
	TIMSK |= (1 << OCIE1A); 
	
	sei(); /* enable interrupt */
	while(1);
	
	return 0;
}
