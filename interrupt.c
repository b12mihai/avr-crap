#include <avr/io.h>
#include <avr/interrupt.h>

#define F_CPU 16000000

ISR(INT1_vect)
{
	while(!(GIFR & (1 << INTF1)));
	PORTD ^= 0b10000000;
}

int main()
{
	/* Initialize registers - control and general */
	MCUCR |= (1 << ISC11);
	GICR |= (1 << INT1);

	DDRD = 0xff;
	PORTD = 0xff;
	
	/* interrupt PD7 to close LED */
	sei();
	while(1);
	return 0;
}
