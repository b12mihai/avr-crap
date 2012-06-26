#include <avr/io.h>
#include <avr/interrupt.h>
#include <stdint.h>

#include "utils.h"

//
//
//  Set of functions for Fast PWM, no prescaling
//
//

void setup_pwm_0(uint8_t duty_cycle){
	DDRB |= 1 << PB3;
	TCCR0 = 0;
	OCR0 = duty_cycle;
	TCCR0 |= (1 << WGM00)  | (1 << WGM01) | (1 << COM01) | (1 << CS00);
}

void set_pwm_0(uint8_t duty_cycle){
	OCR0 = duty_cycle;
}

void setup_pwm_1(uint8_t duty_cycle_A, uint8_t duty_cycle_B){
	DDRD |= (1 << PD5) | (1 << PD4);
	TCCR1A = 0;
	TCCR1B = 0;
	OCR1A = duty_cycle_A;
	OCR1B = duty_cycle_B;
	TCCR1A |= (1 << WGM10) | (1 << COM1A1) | (1 << COM1B1);
	TCCR1B |= (1 << WGM12) | (1 << CS10) ;
}

void set_pwm_1A(uint8_t duty_cycle_A){
	OCR1A = duty_cycle_A;
}

void set_pwm_1B(uint8_t duty_cycle_B){
	OCR1A = duty_cycle_B;
}

void setup_pwm_2(uint8_t duty_cycle){
	DDRD |= 1 << PD7;
	TCCR2 = 0;
	OCR2 = duty_cycle;
	TCCR2 |= (1 << WGM20) | (1 << WGM21) | (1 << COM21) | (1 << CS20);
}

void set_pwm_2(uint8_t duty_cycle){
	OCR2 = duty_cycle;
}

//
//
//  Set of functions for ADC
//
//

void setup_adc(){
	ADMUX = 0;
	ADCSRA = 0;
	ADMUX |= 1 << REFS0;
	ADCSRA |= 1 << ADEN;
}

uint16_t read_adc(uint8_t pin){
	// 10-bit read
	uint16_t result;

	ADMUX &= 0xF0;
	ADMUX |= pin;

	ADCSRA |= 1 << ADSC;
	while( !(ADCSRA & (1 << ADIF)) );
	ADCSRA |= 1 << ADIF;

	result = (ADCH << 8) | ADCL;
	return result;
}

//
//
//  Set of functions for Interrupts
//
//


void setup_interrupt_0(uint8_t mode){
	MCUCR &= ~( (1 << ISC01) | (1 << ISC00) );
	MCUCR |= mode & 0x03;
	GICR |= 1 << INT0;
}

void clear_interrupt_0(){
	GICR &= ~(1 << INT0);
}

void setup_interrupt_1(uint8_t mode){
	MCUCR &= ~( (1 << ISC11) | (1 << ISC10) );
	MCUCR |= (mode & 0x03) << 2;
	GICR |= 1 << INT1;
}

void clear_interrupt_1(){
	GICR &= ~(1 << INT1);
}

void setup_interrupt_2(uint8_t mode){
	MCUCSR &= ~(1 << ISC2);
	MCUCSR |= mode & 0x01;
	GICR |= 1 << INT2;
}

void clear_interrupt_2(){
	GICR &= ~(1 << INT2);
}