#include <stdio.h>

/*
Alisha Patel
I pledge my honor that I have abided by the Stevens Honor System.
State the sorting algorithm you chose in task 3 -> Bubble Sort
State if you want to be considered for bonus points in task 3 -> NO
*/

void strcpy(char* src, char* dst){
	//Your code here

	//intialize the iterating variable outside of the goto loop
	int i = 0;
	copy:
		//setting each index data from src to dst
		dst[i] = src[i];
		//incrementing the varible
	    i++;
	    //the conditional check if the src array is not empty
	    //if it is, stops the goto loop
	    if(src[i] != '\0'){
	        goto copy;
	    }

}


int dot_prod(char* vec_a, char* vec_b, int length, int size_elem){
	//Your code here

	//intializing the incrementing variable, k
	//num1 = offset(index * size of array) pointer
	//num2 = offset pointer
	//result will the product of each index from vector multiplied
	int j = 0;
	int* num1 = vec_a+(j*size_elem);
	int* num2 = vec_b+(j*size_elem);
	int result = 0;
	product:
	//checks to see if the index less then length
	//because out of elements at that point
		if (j < length){
			//assigned index values to the variables
			//result will be used to add all the products together
			//after getting the element
			result += (num1[j]*num2[j]);
			//increments to loop again
			j++;
			goto product;
		}
	return result;
}


void sort_nib(int* arr,int length){
	//Your code here


	unsigned int out[length*8]; // extracting array to put the values in
	int index = 0; //iterating index value through array


	//extracting values from hex
	for(int k = 0; k < length; k++){
		for(int j = 0; j < 8; j++){
			//casting unsigned int from the array index and putting it in the extract
			//shifting 4 times the index value to left to obtain that value
			//and moving to 28 bits right (because of it being 32 bits in total
			//123456 -> 000001
			unsigned int extract = (((unsigned int)arr[k] << (4*j)) >> 28);
			//moving the extract value back into the extracting array
			out[index] = extract;
			index++;

		}
	}


	//bubble sorting array
	//goes through the sorting algorithm for 24 or length*8
	for (int n = 0; n < (length*8); n++){
		for(int m = 0; m < (((length*8) - n)-1); m++){
			//keep swapping until get the intended character
			if(out[m] > out[m+1]){
				int temp = out[m];
				out[m] = out[m+1];
				out[m+1] = temp;
			}
		}
	}




	//initialize variable for 28 bits
	int x = 28;
	//value placeholder for hex values to be stored in
	unsigned int y = 0;
	for(int i = 0; i < length; i++){
		//goes through the original array length
		for(int j = i*8; j<(i*8)+8; j++){
			//iterates through the extraction bits
			//changed into hex and concatenates to binary
			y = (out[j] << x | y);
			//decrements by 4 because of nibble
			x-=4;
		}
		//cast the array back to placeholder for hex values
		arr[i] = (int)y;

		// resets the int array
		y = 0;


	}


}


int main(){
	char str1[] = "382 is the best!";
	char str2[100] = {0};

	strcpy(str1, str2);
	puts(str1);
	puts(str2);

	int vec_a[3] = {12,34,10};
	int vec_b[3] = {10,20,30};
	//int vec_a[3] = {1,1,1};
	//int vec_b[3] = {1,1,128};
	int dot = dot_prod((char*)vec_a, (char*)vec_b, 3, sizeof(int));

	printf("%d\n", dot);

	int arr[3] = {0x12BFDA09, 0x9089CDBA, 0x56788910};
	sort_nib(arr,3);
	for (int i = 0; i < 3; i ++) {
		printf("0x%08x ", arr[i]);
	}
	puts("");

	return 0;
}
