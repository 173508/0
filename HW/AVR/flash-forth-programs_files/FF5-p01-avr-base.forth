\ This forms the beginning of definitions for arduino
\ WARNING ONE time program only. Do not write this repeatedly
\ WARNING It would wear out the Flash memory
\
\ ( c ) Copyright 2023 173508. All rights reserved.
\
\ Revision:
\  v1 - 2023-04-16
\       Initial implementation with basic port definitions for 
\       Arduino Nano board
\
\
empty \ Clean up all older things

decimal \ To correct the base if changed

-avr  \ Create the First marker
marker -avr 

37 constant PORTB	\ Port B Data Register
40 constant PORTC	\ Port C Data Register
43 constant PORTD	\ Port D Data Register
36 constant DDRB	\ Port B Data Direction Register
39 constant DDRC	\ Port C Data Direction Register
42 constant DDRD	\ Port D Data Direction Register
35 constant PINB	\ Port B Input Pins
38 constant PINC	\ Port C Input Pins
41 constant PIND	\ Port D Input Pins

\ Extended Port pins for ATmega2650
(
\ PORTE
46 constant PORTE	\ Data Register, Port E
45 constant DDRE	\ Data Direction Register, Port E
44 constant PINE	\ Input Pins, Port E
\ PORTF
49 constant PORTF	\ Data Register, Port F
48 constant DDRF	\ Data Direction Register, Port F
47 constant PINF	\ Input Pins, Port F
\ PORTG
52 constant PORTG	\ Data Register, Port G
51 constant DDRG	\ Data Direction Register, Port G
50 constant PING	\ Input Pins, Port G
\ PORTH
258 constant PORTH	\ PORT H Data Register
257 constant DDRH	\ PORT H Data Direction Register
256 constant PINH	\ PORT H Input Pins
\ PORTJ
261 constant PORTJ	\ PORT J Data Register
260 constant DDRJ	\ PORT J Data Direction Register
259 constant PINJ	\ PORT J Input Pins
\ PORTK
264 constant PORTK	\ PORT K Data Register
263 constant DDRK	\ PORT K Data Direction Register
262 constant PINK	\ PORT K Input Pins
\ PORTL
267 constant PORTL	\ PORT L Data Register
266 constant DDRL	\ PORT L Data Direction Register
265 constant PINL	\ PORT L Input Pins
)

\ Bit values
%00000001 constant bit0
%00000010 constant bit1
%00000100 constant bit2
%00001000 constant bit3
%00010000 constant bit4
%00100000 constant bit5
%01000000 constant bit6
%10000000 constant bit7

\ Convert number to Binary and Display
: .bin ( c -- )  
  base @ >r 
  2 base ! 
  0 <# # # # # # # # # #>  
  type 
  r> base ! ;

\ Marker at the end of the AVR definition
-avr-base
marker -avr-base

\ Marker used to erase all things till -avr-base
-avr-base-alt
marker -avr-base-alt