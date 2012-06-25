#include<avr/io.h>
#define F_CPU 16000000
#include<util/delay.h>

/* Blinking LED stable 1 s interval between blinks */

int main()
{
	DDRD = 0xFF;
	PORTD = 0xFF;

	while(1) {
		PORTD = PORTD ^ 0xFF;
		_delay_ms(1000);
	}

	return 0;
}
