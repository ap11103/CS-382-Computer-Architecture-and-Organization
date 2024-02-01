/*Alisha Patel
 *bins.s
 *I pledge my honor that I have abided by Stevens Honor System.
 *Created on: Oct 5, 2022
 */

.text
.global _start
.extern printf


_start:

	ADR    X1, arr //loads the base address of arr into X1
	ADR    X2, length //loads the base address of length into X2
	ADR    X3, target //loads the base address of target into X3

    LDR   X2, [X2] //loads the length value into the register
    LDR   X3, [X3] //loading the target value into the register
	MOV   X6, 0 // assigns the value 0 (left index)


bins:  CMP   X2, X6 // compares the length(right) and the left index
	   B.LE  NO //if length <= lowest index, go to NO loop

	   SUB   X8, X2, X6 //subtracts the left most index from the right
	   LSR   X8, X8, 1 //divided the sum by 2 to get the middle
	   ADD   X9, X8, X6 //add the leftmost value and left shifted
	   LSL   X9, X9, 3 //multiplies by 8 (shift 3) for offset
	   LDR   X10,[X1, X9] //stores the value of x9 index into x10
	   CMP   X10, X3 //compares the middle index to the target
	   B.EQ  YES // jumps to the yes label, it's equal

	   CMP   X10, X3 //compares it again
	   B.GT  large //if it is greater than the middle array

	   ADD  X6, X6, 1 //updates the leftmost index, when target is smaller
	   B bins //goto loops to bins


large:    SUB  X2, X2, 1 //updates the rightmost index, when target is larger
	      B bins //goto loops to bins


NO: ADR X0, msg2 //loads the base address of string no into X0
	MOV   X1, X3 //moves the target back in X1
	BL printf //jumps to the printf statement
    B exit

YES: ADR X0, msg1//loads the base address of string yes into X0
	 MOV   X1, X3 //moves the target back in X1
	 BL printf //jumps to the printf statement


exit:
	MOV    X0,    0 //status := 0
	MOV    X8,    93 //exit is syscall #1
	SVC     0 // invoke syscall

.data
arr:     .quad  -40, -25, -1, 0, 100, 300
length:  .quad  6
target:  .quad  -25
msg1:    .string "Target %ld is in the array.'\n'"
msg2:    .string "Target %ld is not in the array.'\n'"





