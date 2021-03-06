#include <avr/io.h>
#include <avr/interrupt.h>
#define F_CPU 16000000
#include <util/delay.h>


ISR(TIMER1_OVF_vect)
{
	/* Reverse PORTD at every 1 second */
	PORTD ^= 0xff;
}

int main()
{
	DDRD = 0xff;
	//PORTD = 0xff;
	
	/* Initialize timers */
	TCCR1A = 0x00;
	TCCR1B |= (1 << CS12);
	
	/* enable overflow flag */
	TIMSK |= (1 << TOIE1); 
	

	_delay_ms(1000);
	sei(); /* enable interrupt */
	while(1);
	return 0;
}
