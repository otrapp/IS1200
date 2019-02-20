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
void print_sieves(int n){
	char A[n]; //set array A to size of n
	for (int i = 0; i < n; i++){
		A[i] = 1; //make everything true
	}
	for (int i =1; i < sqrt(n); i++){		//Do this the square root of n times.
		if (A[i]){
			for (int j =(i+1)*(i+1); j<=n; j=j+i+1)
				A[j-1] = 0;
		}
	}
	for (int i=1; i<n; i++){
		if (A[i])
			print_number(i+1);
	}
}
int main(int argc, char *argv[]) {
	if (argc == 2)
		print_sieves(atoi(argv[1]));
	else
		printf("Please state an interger number.\n");
	return 0;
}
