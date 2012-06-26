//
//
//  Library of low-level functions for the ATMEGA16 microcontroller
//
//  Use at your own risk
//
//

#ifndef _ATMEGA16_AWESOME_FUNCTIONS_
#define _ATMEGA16_AWESOME_FUNCTIONS_

// PWM stuff
void setup_pwm_0(uint8_t duty_cycle);
void set_pwm_0(uint8_t duty_cycle);

void setup_pwm_1(uint8_t duty_cycle_A, uint8_t duty_cycle_B);
void set_pwm_1A(uint8_t duty_cycle_A);
void set_pwm_1B(uint8_t duty_cycle_B);

void setup_pwm_2(uint8_t duty_cycle);
void set_pwm_2(uint8_t duty_cycle);

// ADC stuff
void setup_adc();
uint16_t read_adc(uint8_t pin);

// Interrupt stuff
void setup_interrupt_0(uint8_t mode);
void clear_interrupt_0();

void setup_interrupt_1(uint8_t mode);
void clear_interrupt_1();

void setup_interrupt_2(uint8_t mode);
void clear_interrupt_2();

//
// Trigger modes for external interrupts
//
// Warning: 
// * INT2 can trigger only on falling or rising edge
// (Read the datasheet)
//
#define INT_TRIGGER_LOW		0
#define INT_TRIGGER_CHANGE	1
#define INT_TRIGGER_FALLING	2
#define INT_TRIGGER_RISING	3

#endif