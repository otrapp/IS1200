#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>
#define COLUMNS 6
int count = COLUMNS;
void print_number(int n)
{
	if (count < 1)
	{
		printf("\n");
		count = COLUMNS;
	}
	printf("%10d ", n);
	count--;
}
void nth_sieves(int n){
	int fillArray = n*25;
	int primeCounter =0;
	int A[fillArray]; //set array A to the size of fillArray
	for (int i = 0; i < fillArray; i++){
		A[i] = 1; //make everything true
	}
	for (int i =1; i < sqrt(fillArray); i++){		//Do this the square root of n times.
		if (A[i]){
			for (int j =(i+1)*(i+1); j<=fillArray; j=j+i+1)
				A[j-1] = 0;
		}
	}
	for (int i=1; i<fillArray; i++){
		if (A[i]){
			primeCounter++;//count up to n, only print the nth prime number
			if (primeCounter==n)
						print_number(i+1);
			}
	}
}
int main(int argc, char *argv[]) {
	if (argc == 2)
		nth_sieves(atoi(argv[1]));
	else
		printf("Please state an interger number.\n");
	return 0;
}
