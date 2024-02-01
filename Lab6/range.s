/*Alisha Patel
 *I pledge my honor that I have abided by the Stevens Honor System.
 *range.s -> recursive procedure
 *
 */

.text
.global _start
.extern printf

range:

    CMP    X1,  X2 //compares starting and ending value
	B.EQ   exit//if it's equal, jump to exit for RET

	SUB    SP,  SP, 24 //allocates the space for the stack
	STR    LR, [SP, 0] //stores the adresss value in the array
	STR    X1, [SP, 8] //stores the first value in the stack
	STR    X2, [SP, 16]//stores the last value for reference


	BL printf//prints the value(X0: string; X1: value)
	ADR   X0,  outstr //resets the base address of the string after print
	LDR    X1, [SP, 8] //loads the first value bback into register value
	LDR    X2, [SP, 16] //loads the last value
	ADD    X1, X1, 1 //increments the first value
	BL range //branch links to range


exit:
	LDR  LR, [SP, 0] //loads the address of the SP
	ADD  SP, SP, 24 //deallocates the space in the SP
	RET //return to BL range in the start for recursive call


_start:

    ADR   X0,  outstr //loads the base address of the string
	ADR   X1,  starting //loads the base address of the start of range
	ADR   X2,  ending //loads the base address of the end of range
	LDR   X1, [X1] //loads the value starting
	LDR   X2, [X2] //loads the value of end
	BL range //Branch links to stack


	MOV    X0,    0 //status := 0
	MOV    X8,    93 //exit is syscall #1
	SVC     0 // invoke syscall


.data
starting:   .quad   10
ending:     .quad   15
outstr:     .string "%ld\n"



