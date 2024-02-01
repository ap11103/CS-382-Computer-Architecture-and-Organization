/*Alisha Patel
 *I pledge my honor that I have abided by the Stevens Honor System.
 *findmax.s -> recursive procedure
 *
 */


.text
.global _start
.extern printf


max:

    CMP   X2, 0 //compares the end of length
	B.LT  exit //jumps to the RET

	SUB   X2,    X2, 1 //subtracts the length by 1
	LSL   X5,    X2, 3 //calculates the offset value
	LDR   X6,  [X3, X5] //loads the value at arr[i]

	SUB   SP,   SP,  24//allocates space in the stack
	STR   LR,   [SP, 0] //stores the base address
	STR   X4,   [SP, 8] //stores the length *8 in SP for verification
	STR   X3,   [SP, 16] //stores the address of the array in SP

    LDR   X1,   [SP,  8] //loads the max value in X1 in stack
	LDR   X3,   [SP, 16] //loads the array from the stack
	ADR   X0,   outstr //reloads the base address

	CMP   X6,  X4 //compares the two values
	B.LT  max //jumps to back to recursive call
    MOV   X4,  X6 //switch the values
	BL max //recursive call to max




exit:
	LDR  LR, [SP, 0] //loads the address of the SP
	ADD  SP, SP, 24 //deallocates the space in the SP
	RET //return to BL range in the start for recursive call


_start:

   ADR   X0,  outstr //loads the base address of the string
   ADR   X2,  length //loads the base address of the length
   ADR   X3,  arr  //loads the base address of the arr
   LDR   X2,  [X2] //loads the length value into X2
   MOV   X4,   0 //the temp max value
   BL   max //recursive call to max
   BL   printf //at the end of recursion, print max

   MOV    X0,    0 //status := 0
   MOV    X8,    93 //exit is syscall #1
   SVC     0 // invoke syscall


.data
arr:    .quad    -10, 23, -100, 124, 66, 12
length: .quad     6
outstr: .string   "%ld\n"


