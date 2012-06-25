/*
  AVRUSBBoot - USB bootloader for Atmel AVR controllers

  Thomas Fischl <tfischl@gmx.de>

  License:
  The project is built with AVR USB driver by Objective Development, which is
  published under a proprietary Open Source license. To conform with this
  license, this is distributed under the same license conditions. See
  documentation.

  Target.........: ATMega8 at 12 MHz
  Creation Date..: 2006-03-18
  Last change....: 2006-06-25

  - usbconfig.h:
    You have to adapt USB_CFG_IOPORTNAME, USB_CFG_DMINUS_BIT and 
    USB_CFG_DPLUS_BIT to your hardware.
*/

#include <avr/io.h>
#include <avr/interrupt.h>
#include <avr/pgmspace.h>
#include <avr/wdt.h>
#include <avr/boot.h>

#include "usbdrv.h"
#include "oddebug.h"

#define USBBOOT_FUNC_WRITE_PAGE 2
#define USBBOOT_FUNC_LEAVE_BOOT 1
#define USBBOOT_FUNC_GET_PAGESIZE 3

#define STATE_IDLE 0
#define STATE_WRITE_PAGE 1

static uchar replyBuffer[8];
static uchar state = STATE_IDLE;
static unsigned int page_address;
static unsigned int page_offset;

void (*jump_to_app)(void) = 0x0000;

uchar   usbFunctionSetup(uchar data[8])
{
    uchar len = 0;
    
    if (data[1] == USBBOOT_FUNC_LEAVE_BOOT) {

      cli();
      boot_rww_enable();
      GICR = (1 << IVCE);  /* enable change of interrupt vectors */
      GICR = (0 << IVSEL); /* move interrupts to application flash section */
      jump_to_app();

    } else if (data[1] == USBBOOT_FUNC_WRITE_PAGE) {

      state = STATE_WRITE_PAGE;

      page_address = (data[3] << 8) | data[2]; /* page address */
      page_offset = 0;

      eeprom_busy_wait();
      cli();
      boot_page_erase(page_address); /* erase page */
      sei();
      boot_spm_busy_wait(); /* wait until page is erased */

      len = 0xff; /* multiple out */

    } else if (data[1] == USBBOOT_FUNC_GET_PAGESIZE) {

      replyBuffer[0] = SPM_PAGESIZE >> 8;
      replyBuffer[1] = SPM_PAGESIZE & 0xff;
      len = 2;

    }

    usbMsgPtr = replyBuffer;

    return len;
}


uchar usbFunctionWrite(uchar *data, uchar len)
{

  uchar i;

  /* check if we are in correct state */
  if (state != STATE_WRITE_PAGE)
    return 0xff;
  
  for (i = 0; i < len; i+=2) {

    cli();    
    boot_page_fill(page_address + page_offset, data[i] | (data[i + 1] << 8));
    sei();
    page_offset += 2;

    /* check if we are at the end of a page */
    if (page_offset >= SPM_PAGESIZE) {
      
      /* write page */
      cli();
      boot_page_write(page_address);
      sei();
      boot_spm_busy_wait();

      state = STATE_IDLE;
      return 1;
    }

  }
  
  return 0;
}

static volatile unsigned char counter;
static volatile unsigned char sreg;

#define SBTS(REG, BTS)	(REG) |= (BTS)	// set   bits BTS in REG
#define CBTS(REG, BTS)	(REG) &= ~(BTS)	// clear bits BTS in REG

SIGNAL(SIG_OVERFLOW1)
{	
	sreg	= SREG;		// save status flags
	counter	-= 1;		// may affect ZF, OF, others
	SREG	= sreg;		// restore status flags
}

int main(void)
{
	volatile unsigned char i, j;
	
	GICR = (1 << IVCE);  /* enable change of interrupt vectors */
	GICR = (1 << IVSEL); /* move interrupts to boot flash section */

	PORTD = 0xf3;   /* 1111 0011 bin: activate pull-ups except on USB lines */
	DDRD = 0x0c;    /* 0000 1100 bin: all pins input except USB (-> USB reset) */
	j = 0;
	while(--j){     /* USB Reset by device only required on Watchdog Reset */
		i = 0;
		while(--i); /* delay >10ms for USB reset */
	}
	DDRD = 0x00;    /* 0000 0000 bin: remove USB reset condition */	

	usbInit();
	sei();
	
	// TCNT1 is a 16-bit counter register. max value < 0x10000. is increased at every 256 CLK ticks
	// TCCR1B is used to divide the clock by 256 = 0x100
	// hardware interrupt is generated at after every 0x100 * 0x10000 = 16M	clk ticks
	
	SBTS(SREG, 0x80);	// enable external hardware interrupts
	CBTS(TIFR, 0x04);	// clear timer 1 overflow flag
	SBTS(TIMSK,0x04);	// enable timer 1 overflow interupt
	
	TCNT1	= 0x0000; 	// init counter register
	TCCR1B	= 0x04; 	// start timer 1 with prescaler 256	
	
	counter	= 30;		// time in seconds
	DDRD 	= 0x80; 	// PORTD7 is output	
	
	/* main event loop */
	for(;counter;)
	{
		usbPoll();
		PORTD = (TCNT1 < 0x8000)? 0x80 : 0x00; 	// make led blink
	}
	
	// to work properly, restore interrupts vector address back to 0x0000
	// before jump to address 0x0000 (back to application)
	
	// GICR = (1 << IVCE);  /* enable change of interrupt vectors */
	// GICR = (0 << IVSEL); /* move interrupts to address 0x0000 */
	// asm volatile ("JMP 0");
	
	replyBuffer[1] = USBBOOT_FUNC_LEAVE_BOOT;
	usbFunctionSetup(replyBuffer);

	return 0;
}
