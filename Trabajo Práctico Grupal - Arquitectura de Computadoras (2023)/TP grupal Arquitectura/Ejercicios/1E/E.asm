#include <p16f628a.inc>			
			__config 3f10
			ORG 0X00


			BSF		STATUS,RP0
			BCF		TRISB,0
			BCF		TRISB,1
			BCF		TRISB,2
			BCF		TRISB,3
			BCF 	STATUS,RP0
			CLRF	PORTB
			CALL	Main


Main
		
loop4
			BSF 	PORTB, 0
			CALL	delay_500mili

			BSF 	PORTB, 1
			CALL	delay_500mili

			BSF 	PORTB, 2
			CALL	delay_500mili

			BSF 	PORTB, 3
			CALL	delay_500mili
;ACA SE APAGAN
			BCF		PORTB,3
			CALL	delay_500mili
			
			BCF		PORTB,2
			CALL	delay_500mili

			BCF		PORTB,1
			CALL	delay_500mili

			BCF		PORTB,0
			CALL	delay_500mili

			GOTO 	Main

			
Delay_1mili					
CONT1	EQU		0X20		
			MOVLW	.250
			MOVWF	CONT1
				
loop		NOP
			DECFSZ	CONT1,1
			GOTO	loop
			CLRF	CONT1
			RETURN
	
delay_250mili				
CONT2	EQU		0X21
			MOVLW	.250
			MOVWF	CONT2
loop2		
			CALL	Delay_1mili
			DECFSZ	CONT2,1		
			GOTO	loop2
			CLRF	CONT2
			RETURN

delay_500mili				
CONT5	EQU		0X22
			MOVLW	.2
			MOVWF	CONT5
loop5		
			CALL	delay_250mili
			DECFSZ	CONT5,1		
			GOTO	loop5

			CLRF	CONT5
			RETURN
			
		
			
delay_1SEGUNDO				
CONT3	EQU		0X22
			MOVLW	.4
			MOVWF	CONT3
loop3		
			CALL	delay_250mili
			DECFSZ	CONT3,1		
			GOTO	loop3
			CLRF	CONT3
			RETURN
			
		
			END