\ Typical Blinky Sketch
\
\  We would be blinking PB5 or in the Arduino Pin 13
\
\ ( c ) Copyright 2023 173508. All rights reserved.
\
\ Revision:
\  v1 - 2023-04-16
\    Initial version copied from example at
\   https://arduino-forth.com/article/FORTH_FlashForth_portsArduino
\
decimal

-blinky
marker -blinky

: init-ddrb ( ---)
    bit5 DDRB mset ;

\ Basic LED ON-OFF functions with PB5 or Arduino 13
\: led13-on ( ---)
\    PINB c@            \ Read current Port state using PINB
\    bit5 or              \ PINB | (1<<5)
\    PORTB c! ;        \ PORTB = PINB | (1<<5)
: led13-on ( ---)
    bit5 PORTB mset ;

\: led13-off ( ---)
\    PINB c@             \ Read current Port state using PINB
\    bit5 255 xor        \ (1<<5) ^ 0xFF
\    and PORTB c! ;    \ PORTB = ((1<<5) ^ 0xFF) & PINB
: led13-off ( ---)
    bit5 PORTB mclr ;

\ Blinking Procedure
: blinking ( ---)       \ Blink till Key press
    init-ddrb
    begin
        led13-on   500 ms
        led13-off  500 ms
    key? until ;

\ Use
\ ' blinking is turnkey
\ to start it automatically at startup.
-blinky-end
marker -blinky-end
