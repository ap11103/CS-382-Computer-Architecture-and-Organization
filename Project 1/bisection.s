/* Alisha Patel
 * I pledge my honor that I have abided by the Stevens Honor System.
 * bisection.s
 * Finding a root of a function f(x), which will be a polynomial
 */


.text
.global _start
.extern printf

polynomial:
//result = coef[degree]; result = result * x; result += coef[i]

	MOV   X10,  X0 //assigns i = degree in X10
	LDR   D1,   [X5, X15] //to load the result

    cond3:
	CMP   X10,   0//compares 0 and degree, exit the loop
	B.EQ return //if degree is < 0; return

	FMUL   D1,  D1,  D0 // result = result*x
	SUBS    X10,   X10, 1 //decrement i by 1

	//result = result*x + coef[i]
	LSL    X14,   X10,  3 //offset value for the array
	LDR    D17,   [X5, X14] //loads the value of the array based on the offset

	FADD   D1,    D1,   D17 // result = result*x + coef[i]
	B cond3 //loops back to cond3

return:
	RET //return the result, and jump to the BL


bisec:

//calculates c; (a+b)/2.0
    FADD  D8,  D6,  D7 //D8 = a + b
    FDIV  D8,  D8,  D12 //D8 = c


//calculates f(a), f(c)

	FMOV   D0,    D6 //moves the value of a to D0
	LDR    X0,    [X8] //loads the value of degree to X0
	LSL    X15,   X0,  3 //mutliplies the degree by 8
	LDR    D1,    [X5, X15] //to calculate result += coeff[i]
	BL     polynomial //branch links to polynomial
	FMOV   D9,    D1 //f(a) -> D9


	FMOV   D0,    D8 // moves c to D0
	LDR    X0,    [X8] //loads the value of degree to X0
	LSL    X15,   X0,  3 //mutliplies the degree by 8
	LDR    D1,    [X5, X15] //to calculate result += coeff[i]
	BL     polynomial
	FMOV   D11,   D1 //moves f(c) to D11


    cond1: //bisec goto loop
//-tol < f(c) && f(c) < tol -> end cond1 loop

	FMUL   D15,  D13, D14 //tol * -1 -> -tol
	FCMP   D11,  D13 //f(c) and tol
	B.LT   cond2 //f(c) < tol; end1

	//if f(a) * f(c) < 0; b = c

cond4:
	FMUL   D20,  D9,   D11 //multiply f(a) * f(c)
	FCMP   D20,  0.0 //compare f(a) * f(c) to 0
	B.LT   btoc //jumps to b to c
	FMOV   D6,  D8 // a = c
	B     next //jumps to the next part of the conditional

	btoc: FMOV  D7,  D8 // b = c


	next:
	FADD  D8,  D6,  D7 //D8 = a + b
    FDIV  D8,  D8,  D12 //D1 = c

    FMOV   D0,    D8 // moves c to D0
	LDR    X0,    [X8] //loads the value of degree to X0
	LSL    X15,   X0,  3 //mutliplies the degree by 8
	LDR    D1,    [X5, X15] //to calculate result += coeff[i]
	BL     polynomial
	FMOV   D11,   D1 //moves f(c) to D11
	B cond1

	cond2:
	FCMP   D15, D11 //-tol and f(c)
	B.LT   exit //-tol < f(c); end1
	B     cond4





_start:

	ADR   X5, coeff //loads the base address of the coeff array to X5
	ADR   X6, a //loads the base address of a to X6
	ADR   X7, b //loads the base address of b to X7
	ADR   X8, N //loads the address of the degree
	ADR   X9, tol //loads the address of tolerance


	LDR   D6, [X6] //loads the value of a to D6
	LDR   D7, [X7] //loads the value of b to D7
	LDR   D13,[X9] //loads the tolerance value

	FMOV    D14,  -1  //used for -tol
	FMOV   D12,  2.0 //divde; for c
	ADR    X11,  result //to be used in polynomial
	B     bisec //branches to bisection


exit:

	ADR   X0, str1 //loads the base address of str1
	FMOV  D0, D8 //c to D0
	FMOV  D1, D11 //f(c) to D1
	BL printf

   MOV    X0,    0 //status := 0
   MOV    X8,    93 //exit is syscall #1
   SVC     0 // invoke syscall



.data
coeff:    .double     -7.0, 0.0, 0.0, 0.0, 1.0
N:        .dword      4
a:        .double     1
b:        .double     4
tol:      .double     0.001
result:   .double     0.0
str1:     .string   "root: %lf; f(root): %lf\n"





