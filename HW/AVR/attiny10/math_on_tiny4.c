// +---------------------------------------------------------------------------+
//
//      Program:    math_on_tiny4.c
//
//      Purpose:    Demonstrate the mathematical potential of the ATTiny4,
//                  to show that it is not only good for glue logic
//
//      Author:     Herbert Dingfelder
//
//      License:    GPL 3
//
//      History:    15.02.2015  Initial Coding
//                              Result: 434Bytes of code with long int division,
//                              remainder calculation and timer usage.
//
// +---------------------------------------------------------------------------+

#define F_CPU 1000000
#include <util/delay.h>
#include <avr/io.h>
#include <math.h>


void reset_handler(void);


int main(void) 
{

    long int x, y, z, division, remainder;          // define some variable as long int
    
    reset_handler();
    
    for(;;)                                         // main loop starts here
    {
    
        for( x=1000000; x<2000000 ; x++ )           // run values that really use long
        {
            for( y=30000 ; y<40000 ; y++)
            {
                
                division = x / y;                   // perform a long int division
                remainder = x % y;                  // calculate the remainder 
                
                z = division + remainder;           // use the results on the output,
                if( z & _BV(0) )                    //   otherwise the compiler is so
                    PORTB &= ~_BV(PORTB2);          //   smart that it will optimze 
                else                                //   away the calculations
                    PORTB |=  _BV(PORTB2); 
            
                _delay_ms(1);                       // 1ms delay to make us of the timer
            
            }
            
        }
            
    }
    
    return 0;

}



void reset_handler(void)
{
    
    PUEB  &= ~_BV(PUEB2);                       // disable Pull-Up on PortB, bit 2
    PORTB &= ~_BV(PORTB2);                      // set output on PortB, bit 2, to low
    DDRB |= _BV(DDB2);                          // enable output mode on PortB, bit2
     
}

