#include <avr/io.h>
#include <avr/interrupt.h>
#include <stdint.h>
#include "defines.h"
#include "utils.h"

#define F_CPU 16000000

#define MOTOR_0_DIRECTION_PIN	1
#define MOTOR_0_DIRECTION_PORT	DDRD

#define MOTOR_1_DIRECTION_PIN	1
#define MOTOR_1_DIRECTION_PORT	DDRD

#define MOTOR_2_DIRECTION_PIN	1
#define MOTOR_2_DIRECTION_PORT	DDRD

#define MOTOR_3_DIRECTION_PIN	1
#define MOTOR_3_DIRECTION_PORT	DDRD

ISR(INT0_vect){
	set_pwm_0(255);
}

ISR(INT1_vect){
	set_pwm_0(0);
}


void motor_speed_0(int16_t speed){
	// MOTOR_0_DIRECTION_PIN set => forward
	// MOTOR_0_DIRECTION_PIN cleared => backward
	if(speed < 0){
		MOTOR_0_DIRECTION_PORT |= (1 << MOTOR_0_DIRECTION_PIN);
		speed = -speed;
	} else {
		MOTOR_0_DIRECTION_PORT &= ~(1 << MOTOR_0_DIRECTION_PIN);
	}

	// truncated to 8 bits
	speed = MIN(speed, 255);
	set_pwm_0(speed);
}


void motor_speed_1(int16_t speed){
	if(speed < 0){
		MOTOR_1_DIRECTION_PORT |= (1 << MOTOR_1_DIRECTION_PIN);
		speed = -speed;
	} else {
		MOTOR_1_DIRECTION_PORT &= ~(1 << MOTOR_1_DIRECTION_PIN);
	}

	// truncated to 8 bits
	speed = MIN(speed, 255);
	set_pwm_1A(speed);
}


void motor_speed_2(int16_t speed){
	if(speed < 0){
		MOTOR_2_DIRECTION_PORT |= (1 << MOTOR_2_DIRECTION_PIN);
		speed = -speed;
	} else {
		MOTOR_2_DIRECTION_PORT &= ~(1 << MOTOR_2_DIRECTION_PIN);
	}

	// truncated to 8 bits
	speed = MIN(speed, 255);
	set_pwm_1B(speed);
}


void motor_speed_3(int16_t speed){
	if(speed < 0){
		MOTOR_3_DIRECTION_PORT |= (1 << MOTOR_3_DIRECTION_PIN);
		speed = -speed;
	} else {
		MOTOR_3_DIRECTION_PORT &= ~(1 << MOTOR_3_DIRECTION_PIN);
	}

	// truncated to 8 bits
	speed = MIN(speed, 255);
	set_pwm_2(speed);
}



int main(){
	setup_pwm_0(0);
	setup_pwm_1(0, 0);
	setup_pwm_2(0);

	setup_interrupt_0(INT_TRIGGER_RISING);
	setup_interrupt_1(INT_TRIGGER_RISING);
	return 0;
}