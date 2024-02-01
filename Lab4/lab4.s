/*Alisha Patel
 * lab4.s
 *I pledge my honor that I have abided by the Stevens Honor System.
 * Created on: Sep 27, 2022
 *
 */

 .text
.global _start


_start:
    ADR     X1,    vec1 // stores the base address of vec1
    ADR     X2,    vec2 // stores the base address of vec2
    ADR     X3,    dot // stores the base address of dot

    LDUR    X4,    [X1, 0]//loads the data from vec1(10)
    LDUR    X5,    [X1, 8] //loads the data from vec1(20)
    LDUR    X6,    [X1, 16]//loads the data from vec1(30)

    LDUR    X10,   [X2, 0]//loads the data from vec2(1)
    LDUR    X11,   [X2, 8] //loads the data from vec2(2)
    LDUR    X12,   [X2, 16]//loads the data from vec2(3)


    MUL     X14, X10, X4 //multiplies vec1(10) and vec_2(1)
    MUL     X15, X11, X5 //multiplies vec1(20) and vec_2(2)
    MUL     X16, X12, X6 //multiplies vec_1(30) and vec_2(3)

    ADD     X17, X14, X15//adds the products of (10*1) + (20*2)
    ADD     X18, X17, X16//overwrites the dot with the dot product of vec1 and vec 2

    STUR   X18,  [X3, 0]//stores the dot product computed from X18 to X3

	MOV    X0,    0 //status := 0
	MOV    X8,    93 //exit is syscall #1
	SVC     0 // invoke syscall


.data //data was given
vec1: .quad 10, 20, 30
vec2: .quad  1,  2,  3
dot:  .quad  0




