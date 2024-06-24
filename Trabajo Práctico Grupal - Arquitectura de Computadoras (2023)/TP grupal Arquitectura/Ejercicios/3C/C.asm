#include p16f628a.inc
	
		ORG		0X00
		GOTO	INICIO

		ORG		0X04
		BCF 	INTCON, GIE 
		BTFSS	INTCON,INTF
		GOTO	INT_TMR0
		

		BCF		INTCON,INTF
		BSF		STATUS,RP0
		MOVLW	0X20
		XORWF	OPTION_REG,F
		BCF		STATUS,RP0
		GOTO	SALIR_INT
	
		

INT_TMR0
		INCF	CONT_TMR0,F
		MOVF	CONT_TMR0,W
		XORLW	.20
		BTFSS	STATUS,Z
		GOTO 	SALIR_TMR0



		CALL	MOSTRAR_DISPLAY
		GOTO	TERMINAR


MOSTRAR_DISPLAY
		CLRF	CONT_TMR0
		MOVF 	UNIDAD,0
	
		CALL	DISPLAY
		MOVWF 	PORTB
		
		
		INCF	UNIDAD,1
		DECFSZ  CONT,1
		RETURN
		CLRF	CONT_TMR0
		MOVLW 	.1
		
		MOVWF	CONT
		DECF	UNIDAD,1
		DECF	UNIDAD,1
		MOVF 	UNIDAD,0
	
		CALL	DISPLAY
		MOVWF 	PORTB
		
		
		
		RETURN




		

SALIR_TMR0
		BCF		INTCON,T0IF
		MOVLW	.61
		MOVWF	TMR0			

TERMINAR

SALIR_INT	

		BCF INTCON, GIE ; habilito nuevamente las interrupciones
		RETFIE

INICIO
		BSF INTCON, GIE ; Habilito las interrupciones globales
		BSF INTCON, INTE ; Habilito la interrupción por RB0
		BSF INTCON, T0IE

		BSF		STATUS,RP0
		BCF 	OPTION_REG,NOT_RBPU;boton
		BCF		OPTION_REG,T0CS; timer0
		BCF		OPTION_REG,PSA;0=PREESCALER=si
			
		BSF	OPTION_REG,2    ;ps2=1
		BSF	OPTION_REG,1    ;ps1=1
		BSf	OPTION_REG,0    ;ps0=1
		

		BSF		TRISB,0
		BCF		TRISB,1
		BCF		TRISB,2
		BCF		TRISB,3
		BCF		TRISB,4
		BCF		TRISB,5
		BCF		TRISB,6	
		BCF		TRISB,7
		BCF 	STATUS,RP0

		

		CLRF	PORTB	
		MOVLW	.0
		MOVWF	TMR0

UNIDAD	EQU		0X30
		movlw	.7
		movwf	UNIDAD			
CONT_TMR0	EQU	0X31
		CLRF	CONT_TMR0

CONT	EQU		0X27
		MOVLW	.17
		MOVWF	CONT


		GOTO	$

DISPLAY

		ADDWF 	PCL,1
REINICIAR		
		
		MOVLW	.7
		MOVWF	UNIDAD
		MOVLW	.17
		MOVWF	CONT
		retlw 	0x7F	;0
		RETURN	
		
		GOTO 	REINICIAR
		
		retlw 	0x7F	;0
		retlw 	0x0C	;1	
		retlw 	0xB6	;2
		retlw 	0x9E	;3
		retlw 	0xCC	;4
		retlw 	0xDA	;5
		retlw 	0xFA	;6
		retlw	0x0E	;7
		retlw	0xFE	;8
		RETLW	0XDE	;9
		RETLW	0xEE	;a
		RETLW	0xF8	;b
		RETLW	0x72	;c
		RETLW	0xBC	;d
		RETLW	0xF2	;e
		RETLW	0xE2	;f

		RETURN

		END