/* Alisha Patel
 * lab11.s
 * I pledge my honor that I have abided by the Stevens Honor System.
 *  Created on: Nov 29, 2022
 */

.text
.global _start



read:
	MOV  X0, 0 //saving register
	ADR  X1, empty_arr //stores the array
	MOV  X2, 1 //nbyte
	MOV  X8, 63 //syscall to read
	SVC  0 //invoke syscall


	LDR  X5, [X1, 0] //loads the first element
	CMP  X6,  X5 //compare the character with a null terminator
	B.EQ finish //jumps to exit

	SUB  X5, X5, 48 //gets the integer
	MUL  X20, X20, X6 //determines the 10th power
	ADD  X20, X20, X5 //the total
	B read

finish:
	MOV   X0,  X20 //moves the sum to X0
	RET

split:

	CMP  X26, X6 //compares with the 10
	B.LT finish2
	MUL  X24, X24, X6//keeps track for 10^n
	UDIV X26, X26, X6
	B split

write:

	UDIV X26, X4, X24 //isolate the leftmost digit
	ADD  X27, X26, 48 //adds to convert it to ascii
	STR  X26, [X1] //stores the character into buffer
	MOV  X0, 0
	ADR  X1, empty_arr
	MOV  X2, 1
	MOV  X8,  64 //syscall to write
	SVC  0 //invoke syscall

	UDIV X20, X4, X6 //unsigned division by 10
	MUL  X21, X26, X24  //multiplies the quotient
	SUB  X4,  X4, X21 //subtracts the quotient from the number
	UDIV X24, X24, X6 //divides X24 by 10
	CBZ  X24, finish2
	B write



/*
	UDIV X20, X4, X6 //unsigned division by 10
	CMP  X20, X23 //compares the quotient to 1
	B.EQ exit //if the quotient is 0, done splitting
	MUL  X21, X6, X20 //multiply the quotient by 10
	SUB  X22, X4, X21 //subtracts the quotient from the number
	ADD  X22, X22, 48 //makes ascii
	ADD  X25, X25, 8//to calculate the offset for an array
	STR  X22, [X1] //stores it into X1
	MOV  X4, X20 //moves the quotient in product

	MOV  X0, 1 //fd = 1
	ADR  X1, empty_arr //buffer
	MOV  X2, 1//nbyte
	MOV  X8, 64 //syscall to write
	SVC  0 //invoke syscall

	B write //branches back to write
*/

finish2:
	RET

_start:
	MOV  X7, 0//increment register
	MOV  X6, 10 //X6 stores 10
	BL  read //branch link to the loop


	MOV  X4, X0 //moves the integer value
	MUL  X4, X4, X4 //squares the value
	MOV  X24, 1 //nbyte
	MOV  X26, X4 //copy of the squared value
	MOV  X23, 0 //to compare for splitting

	BL split
	BL write



exit:
	MOV    X0,    0 //status := 0
	MOV    X8,    93 //exit is syscall #1
	SVC     0 // invoke syscall




.bss
    empty_arr:  .skip   1//empty array
.data

