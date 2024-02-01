/*Alisha Patel
 *reverse.s
 *I pledge my honor that I have abided by Stevens Honor System.
 * Created on: Oct 5, 2022
 */

.text
.global _start

_start:

    ADR    X1, arr //loads the base address of the arr
    ADR    X10, length //loads the base address of length
    MOV    X11, 4 //assigns the length of a nibble to X11
    LDR    W12, [X10] //loads the length into X12
    ADD    X12, X12, 1 //increments the length so the loop would have the length

    begin:
    MOV   X18, 0 //assigns the increment i to 0
    SUB   X12, X12, 1 //decreases the length
    LSL   X13, X12, 2 // left shifts (multiplies by 2^2) to the element
    SUB   X13, X13, 4 // X25 gets subtracted by 4(nibble)

    CMP   X13, 0 //checks if the register value is greater than 0
    B.GE  nibbleswap //if it >=, it will go the nibbleswap

    MOV   X13, 0 //assigns 0 back to X13
    ADR   X15, length // gets the length of the elements
    LDR   W16, [X15] //loads the word format of the length into register 16
    LSL   X14, X16, 2 //updates the X14 by multiplying the rightmost index by 4
    SUB   X14, X14, 4 //subtracts the 4 from the rightmost index value
    B wordswap //goto loops to wordswap


    nibbleswap:
    LDRB   W2, [X1, X13] //loads the first nibble
    LSR    W3, W2, 4 //right shifts 4 places to get to the next byte
    LSL    W4, W2, 28 // left shifts 28 to 0 out the all the other value
    LSR    W4, W4, 28 //then right shifts again 28
    LSL    W5, W4, 4 //left shifts the value again by 4, to implement(arr[k] << (4*j)) >> 28)
    ORR    W5, W5, W3 //or the X5 and X3 that shifted 4 places to concatenate the flipped nibbles
    STRB   W5, [X1, X13] //stores the flipped nibble back
    ADD   X13, X13, 1 //increment the index to go to the next element in the arr
    ADD   X18, X18, 1 // increments the i by 1
    SUB   X17, X11, X18 //check if the i is greater than 4
    CBNZ  X17, nibbleswap //if X17 doesn't equal to 0, jumps to nibbleswap

    SUB   X13, X13, 1 //deincrements the index by 1
    LDRB  W6,  [X1, X13] //loads the front nibble to X6 from array 2
    SUB   X13, X13, 3 //goes from first index to last bit
    LDRB  W7,  [X1, X13] //loads the back nibble to X6
    STRB  W6,  [X1, X13] //stores the front val to the back nibble
    ADD   X13, X13, 3 //updates the index by adding 3
    STRB  W7,  [X1, X13] //stores the back to front nibble
    ADD   X13, X13, 1 //assign 1 to X13
    SUB   X13, X13, 2 //gets the middle's index val
    LDRB  W8,  [X1, X13]//loads the middle nibble to array 2
    SUB   X13, X13, 1 // goes to the next index
    LDRB  W9,  [X1, X13] //loads the next part of middle
    STRB  W8,  [X1, X13] //stores the first part of the middle into next
    ADD   X13, X13, 1 //gets to previous middle index
    STRB  W9, [X1, X13] //stores the next part of middle into first
    ADD   X13, X13, 2 //updates the index to max
    B begin //goto loops to the start


    wordswap:
    CMP   X16, 1 //if there number of words on the left equals to 1
    B.EQ  exit //if it is equal, jumps to the exit label
    CMP   X16, 0 //if the length equals to 0
    B.EQ  exit //if it is equal, jumps to the exit label

    LDR   W11, [X1, X13] //loads the index value of the leftmost val in array
    LDR   W12, [X1, X14] //loads the index value of the rightmost val in array
    STR   W11, [X1, X14] //stores the new right in new array
    STR   W12, [X1, X13]//stores back the new left in new array

    SUB   X16, X16, 2//takes away the 2
    ADD   X13, X13, 4 //add 4 to X25
    SUB   X14, X14, 4 //subtracts 4 from X14
    B wordswap //goto loops to the word swap for array

exit: MOV    X0,    0 //status := 0
	  MOV    X8,    93 //exit is syscall #1
	  SVC     0 // invoke syscall

.data
arr:     .word  0x12BFDA09,  0X9089CDBA,  0X56788910
length:  .word  3
