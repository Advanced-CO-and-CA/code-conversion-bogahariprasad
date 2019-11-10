	.global main
	.data
STRING: .ascii "11010710"
NUMBER: .byte 0x00
ERROR:  .byte 0xFF
	.text
main: 
	LDR R6,=STRING 				@load the address of STRING
	LDR R9,=NUMBER 				@load the address of NUMBER
	LDR R3,=ERROR 				@load the address of ERROR
	EOR R5,R5,R5 				@clear R5 to store result
	EOR R1,R1,R1 				@clear R1 to store length
LOOP:
	LSL R5, R5, #1				@OR with existing result and shift left by 1 bit.
	ADD R1,R1,#1 				@increment the count
	LDRB R7,[R6],#1 			@load the STRING first ascii character into R7
	CMP R7, #'1'				@compare with '1'
	BGT EXIT					@if ascii character is not '0' or '1', goto exit.
	SUB R7, R7, #'0'			@subtract '0' to get binary result
	ORR R5, R7					@OR with existing result
	CMP R1, #8
	BNE LOOP					@loop for 8 ascii characters
	EOR R1,R1,R1 				@clear R1 to clear the error on success case.
	STRB R1,[R3]				@clear the error.
	STRB R5,[R9] 				@otherwise, store the result in NUMBER
EXIT:
	SWI 0x11
	.end

