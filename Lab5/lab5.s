/*Alisha Patel
 *lab5.s
 *I pledge my honor that I have abided by the Stevens Honor System.
 *
 */


.text
.global _start

_start:

	ADR    X2,   p1 //loads the p1 base address to X2
	ADR    X3,   p2 //loads the p2 base address to X3
	ADR    X4,   p3 //loads the p3 base address to x4


	LDUR   X7,   [X2, 0]//loads the p1[0] = 0 to X7
	LDUR   X8,   [X2, 8]//loads the p1[1] = 0 to X8

	LDUR   X9,   [X3, 0]//loads the p2[0] = 0 to X9
	LDUR   X10,  [X3, 8]//loads the p2[1] = 2 to X10

	LDUR   X11,  [X4, 0]//loads the p3[0] = 0 to X11
	LDUR   X12,  [X4, 8]//loads the p3[1] = 0 to X12

	SUB    X13,  X7,  X9 // (p1[0] - p2[0] = 0
	MUL    X15, X13, X13 //squares the previous difference
	SUB    X14,  X8, X10 // (p1[1] - p2[1] = 2
	MUL    X16, X14, X14 //squares the previous difference
	ADD    X17, X15, X16 //adds up the squares

	MUL    X18, X11, X11//squares the p3[0] = 4
	MUL    X19, X12, X12 //squares the p3[1] = 0
	ADD    X20, X18, X19 //add squares for p3
	SUB    X21, X17, X20 //subtract X17 and X20
	CBZ    X21, label1 //if both squares are equal -> label1


	SUB    X13,  X7,  X11 // (p1[0] - p3[0] = 2
	MUL    X15, X13, X13 //squares the previous difference
	SUB    X14,  X8, X12 // (p1[1] - p3[1] = 0
	MUL    X16, X14, X14 //squares the previous difference
	ADD    X17, X15, X16 //adds up the squares

	MUL    X18, X9, X9//squares the p2[0] = 0
	MUL    X19, X10, X10 //squares the p2[1] = 4
	ADD    X20, X18, X19 //add squares for p2
	SUB    X21, X17, X20 //subtract X17 and X20
	CBZ    X21, label1 //if both squares are equal -> label1


	SUB    X13,   X9,  X11 // (p2[0] - p3[2] = 2
	MUL    X15,  X13,  X13 //squares the previous difference
	SUB    X14,  X10,  X12 // (p2[1] - p3[1] = 0
	MUL    X16,  X14,  X14 //squares the previous difference
	ADD    X17, X15, X16 //adds up the squares

	MUL    X18, X7, X7//squares the p1[0] = 0
	MUL    X19, X8, X8 //squares the p1[1] = 0
	ADD    X20, X18, X19 //add squares for p1
	SUB    X21, X17, X20 //subtract X17 and X20
	CBZ    X21, label1 //if both squares are equal -> label1

	ADR    X1,   no//loads the base address of no X1
	B exit //jumps to the exit call of the function after loading no



	label1: ADR    X1,   yes //loads yes to X1

exit:
	MOV    X0,    0 //status := 0
	MOV    X8,    93 //exit is syscall #1
	SVC     0 // invoke syscall


.data
p1:  .quad   0, 0
p2:  .quad   0, 2
p3:  .quad   2, 0
//p1:  .quad   1, 2
//p2:  .quad   3, 3
//p3:  .quad   4, 4
yes: .string "It is a right triangle."
no:  .string "It is not a right triangle."

