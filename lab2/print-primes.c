/*
 print-prime.c
 By David Broman.
 Last modified: 2015-09-15
 This file is in the public domain.
*/
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
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
int is_prime(int p){
    if (p<2)
      return 0; //tal under 2 kan ej vara primtal
    if (p==2)
      return 1; //talet 2 är ett primtal
    if (p%2==0)
      return 0; //om n är jämnt delbart med 2 så kan det inte vara ett primtal.
    for(int i=2; i<=sqrt(p);i++) //kolla om roten ur n är mindre än eller lika med i, läggt till 1 till i tills det inte stämmer längre
    {
      if(p%i==0)
        return 0; //ingen rest så är det inte ett primtal
    }
  return 1;  //annars ett primtal
}
void print_primes(int n){
  // Should print out all prime numbers less than 'n'
  // with the following formatting. Note that
  // the number of columns is stated in the define
  // COLUMNS
  /**/
  int primenumber;
  int p=2;
  while (p<=n){
    primenumber = is_prime(p);
    if (primenumber){
      print_number(p);
      p++;
    }
    else
      p++;
  }
  printf("\n");
}
// 'argc' contains the number of program arguments, and
// 'argv' is an array of char pointers, where each
// char pointer points to a null-terminated string.
int main(int argc, char *argv[]){
  if(argc == 2)
    print_primes(atoi(argv[1]));
  else
    printf("Please state an integer number.\n");
  return 0;
}
