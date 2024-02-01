/* Alisha Patel
 * lab12.s
 * I pledge my honor that I have abided by the Stevens Honor System.
 *  Created on: Dec 6, 2022
 */

.text
.global _start


 read:
    MOV   X0, 0 //saving register
    ADR   X1, empty_arr //buffer array
    MOV   X2, 1 //nbyte
    MOV   X8, 63 //syscall number for read
    SVC   0 //invoke syscall


    LDR   X20, [X1] // load from input
    CMP   X20, 10 //compares to null terminator
    B.EQ final //equal to 0; RET
    SUB   X20, x20, 48 //ascii conversion
    MUL  X19, X19, X18 //mulitplies it by 10
    ADD  X19, X19, X20 //adds the next item
    B read



write:
	UDIV X20, X19, X24 // divides the number by 100^n so we isolate left most digit
	ADD  X26, X20, 48 // adds 48 so it converts to ascii
	STR  X26, [X1] // stores the character in buffer

	MOV  X0, 0 ////saving register
	ADR  X1, empty_arr //buffer array
	MOV  X2, 1 //nbyte
	MOV  X8, 64 // set syscall number for write
	SVC 0 //invoke syscall


	MUL  X21, X20, X24 // multiplies the quotient by 10
	SUB  X19, X19, X21 //subtracts the quotient from the number
	UDIV X24, X24, X6 // divides x24 by 10 since there is 1 less digit now
	CBZ  X24, final // if the quotient is 0; exit
	B write




_start:

    MOV X24, 1 //power of 10
    MOV X6, 10 //holds 10

    MOV X0, 0 //saving register
    ADR X1, empty_arr // loads address of input string
    MOV X2, 1 // sets # of characters that can be processed at a time

    MOV X18, 10 //compares to null terminator

    BL read // calls the read procedure
    MUL X19, X19, X19 //computes the square
    MOV X20, X19 //makes the copy of the number to be referenced in split

    BL split

    BL write



    MOV X0, 0 //reset
    MOV X8, 93 //syscall for exit
    SVC 0 //invoke syscall


split:
    CMP X20, 10
    B.LT final
    MUL X24, X24, X6
    UDIV X20, X20, X6
    B split


final:
	RET



.bss
    empty_arr: .skip 8
