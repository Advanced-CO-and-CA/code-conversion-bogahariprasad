.global main
.data
	A_DIGIT: .byte 0x43
.bss
	H_DIGIT: .byte 0
.text
main: 
	LDR R0,=A_DIGIT @load the address of A_DIGIT
	LDR R2,=H_DIGIT @load the address of H_DIGIT
	LDR R1,[R0]     @Load the A_DIGIT into R1
	CMP R1,#0x41    @if the number < 0x41 then [A-F]
	BLT Add_0       @then branch to [0-9]
	ADD R1,R1,#0xA-0x41 @Add difference to A
	B STORE
Add_0: 
	SUB R1,R1,#0x30  @calculate the difference
STORE:
	STR R1,[R2]      @store the H_DIGIT value into its address
	SWI 0x11
.end

