/*lab2.c
 *Author: Alisha Patel
 * Created on: Sep 13, 2022
 * PLedge: "I pledge my honor that I have abided by the Stevens Honor System."
 */

#include <stdio.h>
#include <stdlib.h>

void display(int8_t bit){
	putchar(bit + 48);
}

void display_32(int32_t num){
	//Shifting right, and then 1 for masking operations
	for (int i = 31; i >= 0; i--){
		display((num >> i) & 1);

	}
}

int main(int argc, char const *argv[]){
	display_32(1993);
	//display_32(0);
	//display_32(437865);
	return 0;
}


