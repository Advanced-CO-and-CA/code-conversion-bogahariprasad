	.global main
	.data
BCDNUM: .ascii "92529679"
NUMBER: .word 0x00000000
	.text
main: 
	LDR R6,=BCDNUM 				@load the address of BCDNUM
	LDR R9,=NUMBER 				@load the address of NUMBER
	EOR R5,R5,R5 				@clear R5 to store result
	EOR R1,R1,R1 				@clear R1 to store length
	MOV R2, #10
LOOP:
	ADD R1,R1,#1 				@increment the count
	LDRB R7,[R6],#1 			@load the BCDNUM first digit into R7
	SUB R7, R7, #'0'			@subtract '0' to get the digit value
	MLA R5,R5,R2,R7				@R5 <- (R5×10)+R7
	CMP R1, #8
	BNE LOOP					@loop for 8 digits
	STR R5,[R9] 				@store the result
	SWI 0x11
	.end

