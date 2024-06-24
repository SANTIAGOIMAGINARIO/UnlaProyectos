;INCLUDE Y CONFIGURACIÓN
#INCLUDE<P16F628A.INC>
__CONFIG 3F10

;=================================================
;============RUTINA DE INTERRUPCIÓN===============
;=================================================
org 0x04
		 bcf INTCON, GIE		;Inhabilito: Interrupciones globales	
    		 bcf INTCON, INTF		;Inhabilito; Flag
   		 bsf PORTB, RB0     		;Pongo en 1 a RB0	
		 bsf INTCON, GIE
      		 retfie

;================================================
;====================MAIN========================
;================================================
org 0x00
    		 clrf TRISB
   		 bsf STATUS, RP0
    		 clrf CONTADOR
   		 clrf ESTADO
   		 bcf STATUS, RP0
		 bsf INTCON, GIE
    		 bsf INTCON, INTE
;================================================
;================MAIN_2==(CHECK CAMINO)==========
Delay_Loop	
   		 movf ESTADO, W
   		 xorlw .1
   		 btfss STATUS, Z
   		 goto Display_Apellido
   		 goto Display_Dni
;================================================
Display_Apellido
  		 movlw b.'11011010'  		;S
  		 call  Mostrar_En_Display
		 goto  Delay_500ms 

   		 movlw b.'11101110'		;A
  		 call  Mostrar_En_Display
		 goto  Delay_500ms 

  		 movlw b.'01100000'		;I
   		 call  Mostrar_En_Display
		 goto  Delay_500ms 

		 movlw b.'01100010'		;T
		 call  Mostrar_En_Display
		 goto  Delay_500ms 

		 movlw b.'10010010'		;Z
		 call  Mostrar_En_Display
		 goto  Delay_500ms 


		 goto  	Delay_Loop

;===================================
Display_Dni
   		 movlw b.'11001100'		;4
   		 call  Mostrar_En_Display
		 goto  Delay_500ms 

   		 movlw b.'10011110'		;3
   		 call  Mostrar_En_Display
		 goto  Delay_500ms 

   		 movlw b.'11011010'		;5
   		 call  Mostrar_En_Display;
		 goto  Delay_500ms 

		 movlw b.'00001100'		;1
 	 	 call  Mostrar_En_Display
	 	 goto  Delay_500ms 

		 movlw b.'11111110'		;8
		 call  Mostrar_En_Display
		 goto  Delay_500ms 

		 movlw	b'00001110'		;7
 		 call  Mostrar_En_Display
		 goto  Delay_500ms 
		
		 movlw b.'11001100'		;4
 		 call  Mostrar_En_Display
		 goto  Delay_500ms

		 movlw b.'11111110'		;8
		 call  Mostrar_En_Display
		 goto  Delay_500ms 


     		 goto  Delay_Loop

;================================================
;=================MUESTRA EN EL DISPLAY==========
;================================================
Mostrar_En_Display
   		 movwf PORTB	
   		 goto Delay500ms

;================================================
;=====================DELAYS=====================
;================================================
Delay_1ms
		movlw	.250
		movwf	CONTADOR_LOOP_1,
LOOP_1	nop	
		decfz	CONTADOR_LOOP_1,f
		goto	LOOP_1
		return
;================================================
Delay_250ms
		movlw	.250
		movwf	CONTADOR_LOOP2
LOOP_2	call 	Delay_1ms	
		decfz	CONTADOR_LOOP_2,f
		goto	LOOP_2	
		return
;================================================
 Delay_500ms 
		movlw	.250
		movwf	CONTADOR_LOOP_3
LOOP_3	call 	Delay_250ms	
		decfz	CONTADOR_LOOP_3,f
		goto	LOOP_3
		return
;================================================
	
END  