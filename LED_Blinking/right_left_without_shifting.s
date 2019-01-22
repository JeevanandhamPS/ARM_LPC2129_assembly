 			 ;;;    SCHOOL OF LINUX    ;;;
    
;Author => "Jeevanandham.P.S"
;Date   => 29dec2018




			AREA PIN_SEL,CODE,READONLY
			ENTRY
 
PINSEL0 	EQU 0xE002C000			; GPIO enable address
IO0DIR 		EQU 0xE0028008          ; I/O direction
IO0SET 		EQU 0xE0028004          ; pin set...
IO0CLR 		EQU 0xE002800C          ; clear the set... 
IO0PIN 		EQU 0xE0028000

;make the pins as General Purpose Input/Output

			LDR R0,=PINSEL0			; load the address to R0
			LDR R1,[R0]             ; load the R0 value to R1
			MOV R1,#0X00000000      ; mov all bits are zero to R1 (all pins are GPIO if zero means)
			STR R1,[R0]             ; store R1 values to R0
	
			LDR R0,=IO0DIR 			; load the address to R0		
			LDR R1,[R0]             ; load the R0 values 
			MOV R3,#0XFFFFFFFF      ; all are 1 means output pins
			ORR R1,R3               ; store the R1 values to R0
			STR R1,[R0]
__main
			MOV R4,#0X00000001
			MOV R5,#0X00000020
			
			LDR R6,=0x000000FF
;we make 255 no operation cycle	
time_		
			NOP
			NOP
			SUBS R6,#0X1			
			BNE time_
			
			
shift
			LDR R0,=IO0SET 			; load the IO0SET address to R0
			LDR R1,[R0]             ; load the R0 values 
			MOV R1,R4               ; Move R4 value to R1
			STR R1,[R0]             ; store the R0 values to R1
			
			LDR R6,=0X0000FFFF
;we make 65535 no operation cycle	
time		
			NOP
			NOP
			NOP
			NOP
			SUBS R6,#0X1			
			BNE time
	
			LDR R0,=IO0CLR			; load the IO0CLR address to R0
			LDR R1,[R0]             ; load the R0 values 
			MOV R1,R4               ; Move R4 value to R1
			STR R1,[R0]             ; store the R0 values to R1
			
			ADDS R4,R4				; R4 = R4 + R4
	
			LDR R6,=0x000000FF
;we make 255 no operation cycle	
time1
			NOP
			NOP
			SUBS R6,#0X1			
			BNE time1
			
			SUBS R5,#0X1			; R5 = R5 - 1			
			BNE shift
			B   __main
			END 
