/*
 prime.c
 By David Broman.
 Last modified: 2015-09-15
 This file is in the public domain.
*/


#include <stdio.h>
#include  <math.h>
int is_prime(int n){
    if (n<2)
      return 0; //tal under 2 kan ej vara primtal
    if (n==2)
      return 1; //talet 2 är ett primtal
    if (n%2==0)
      return 0; //om n är jämnt delbart med 2 så kan det inte vara ett primtal.
    for(int i=2; i<=sqrt(n);i++) //kolla om roten ur n är mindre än eller lika med i, läggt till 2 till i tills det inte stämmer längre
    {
      if(n%i==0)
        return 0; //ingen rest så är det inte ett primtal
    }
  return 1;  //annars ett primtal
}

int main(void){
  printf("%d\n", is_prime(11));  // 11 is a prime.      Should print 1.
  printf("%d\n", is_prime(383)); // 383 is a prime.     Should print 1.
  printf("%d\n", is_prime(987)); // 987 is not a prime. Should print 0.
}
