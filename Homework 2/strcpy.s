/*Alisha Patel
 *strcpy.s
 *I pledge my honor that I have abided by Stevens Honor System.
 * Created on: Oct 5, 2022
 */

.text
.global _start

_start:

	  ADR    X1, src_str //loading the base address of the source string
	  ADR    X2,  dst_str //loading the base address of the destination string

      MOV   X3, 0 //assign i = 0, the iterating variable
      MOV   X5, #0x00 //assigns the null terminator to a register
copy: LDRB  W4,  [X1, X3] //access the first byte of the string
	  STRB  W4,  [X2, X3] // copies the byte into destination register
	  CMP  X4, X5 //compares to see if the iterator is equal to the null terminator
	  B.EQ exit //if it is 0, goes to the end of the function
	  ADD  X3, X3, 1 //increments i by 1 (i++)
	  B copy // calls the copy loop as default


exit: MOV    X0,    0 //status := 0
	  MOV    X8,    93 //exit is syscall #1
	  SVC     0 // invoke syscall
.data
src_str: .string "I love 382 and assembly!" //source string

.bss
dst_str: .skip  100 //destination string




