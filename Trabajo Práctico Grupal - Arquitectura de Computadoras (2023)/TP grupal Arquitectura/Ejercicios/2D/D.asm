#include <p16f628a.inc>
	
UNIDAD	EQU		0X30


		ORG		0X00
		GOTO	INICIO

		ORG		0X04
		BCF 	INTCON, GIE ; inhabilito las interrupciones globales
		BCF 	INTCON, INTF ; bajo el flag de la interrupción
		
		MOVF 	UNIDAD,W
		CALL	LUCES
		MOVWF 	PORTB
			
		INCF	UNIDAD,1

		BSF 	INTCON, GIE ; habilito nuevamente las interrupciones

		RETFIE


INICIO
		BSF 	INTCON, GIE ; Habilito las interrupciones globales
		BSF 	INTCON, INTE ; Habilito la interrupción por RB0

		BSF		STATUS,RP0
		BCF 	OPTION_REG,NOT_RBPU;boton

		BSF		TRISB,0
		BCF		TRISB,1
		BCF		TRISB,2
		BCF 	STATUS,RP0

		CLRF	PORTB	

		MOVLW	.1
		MOVWF	UNIDAD			

		GOTO	$


LUCES

		ADDWF 	PCL,1

		NOP
		
		RETLW	b'00000010'
		RETLW	b'00000110'
		RETLW	b'00000100'
		RETLW	b'00000000'

		MOVLW	.0
		MOVWF	UNIDAD
	
		RETURN


Delay_250ms

CONT2	EQU		0X21

		MOVLW	.250
		MOVWF	CONT2

Loop2
		CALL	Delay_1ms
		DECFSZ	CONT2,1
		GOTO	Loop2

		CLRF	CONT2

		RETURN


Delay_1ms

CONT1	EQU		0X20

		MOVLW	.250
		MOVWF	CONT1

Loop1
		NOP
		DECFSZ	CONT1,1
		GOTO	Loop1

		CLRF	CONT1

		RETURN	


		END	