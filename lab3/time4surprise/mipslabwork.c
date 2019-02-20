/* mipslabwork.c

  This file written 2015 by F Lundevall
  Updated 2017-04-21 by F Lundevall

  This file should be changed by YOU! So you must
  add comment(s) here with your name(s) and date(s):

  This file modified 2217-04-31 by Ture Teknolog

  For copyright and licensing, see file COPYING */

#include <stdint.h>   /* Declarations of uint_32 and the like */
#include <pic32mx.h>  /* Declarations of system-specific addresses etc */
#include "mipslab.h"  /* Declatations for these labs */

volatile char *initE;
volatile char *portE;

int tickCount =0;
int timeOutCount =0;
int sw;
int mytime = 0x5957;
int prime = 1234567;

char textstring[] = "text, more text, and even more text!";

/* Interrupt Service Routine */
void user_isr( void )
{
  if(IFS(0)&0x100)//kolla om bit [8] är 1
  {
    IFSCLR(0)=0x100; //sätt bit [8] till 0
    timeOutCount++;
    tickCount++;
    *portE =(tickCount); //| 0xf00;
    if(timeOutCount==10)
    {
      time2string( textstring, mytime );
      display_string( 3, textstring );
      display_update();
      tick( &mytime );
      timeOutCount=0;
    }
  }
  if(IFS(0)&0x800) //Kolla om bit [11] är 1
  {
    IFSCLR(0)=0x800; //reset bit [11]
    mytime+=2;
    time2string( textstring, mytime );
    display_string( 3, textstring );
    display_update();
  }


 return;
}

/* Lab-specific initialization goes here */
void labinit( void )
{
        //LEDs
       TRISD = TRISD | 0x0fe0; //bitwise oring TRISD
       initE = (char*) 0xbf886100;
       *initE = *initE & 0xffffff00;
       portE = (char*) 0xbf886110 ;

       // Timer
       T2CON = 0x70; //bits 111 sets the prescaler to 256
       PR2 = ((80000000/256)/10); //divides the period in 10 so that it will be ~100ms
       TMR2 = 0;//sets the time to 0 so that we know where we're starting to count from
       T2CONSET = 0x8000; //Starts the timer by setting the ON bit to 1 (bit 15)

      //Interrupts
      IPC(2) = 0x3f; //sets priority to 7 and subprio to 3
      IEC(0) = 0x900; // should enable the interrupts by setting bit [8] and [11] to 1

                      //T2IF is bit [8] in IFS0

                      //T2IE is bit [8] in IEC0
                      //T2IP are bits [2,3,4] in IPC2
                      //T2IS are bits [0] and [1] in IPC2

                      //INT2IF is bit [11] in IFS0
                      //INT2IE is bit [11] in IEC0
                      //INT2IP are bits [26,27,28] in IPC2
                      //INT2IS are bits [24,25] in IPC2





      enable_interrupt();
return;
}

/* This function is called repetitively from the main program */
void labwork(void)
{
  prime = nextprime (prime);
  display_string(0, itoaconv(prime));
  display_update();
   //delay( 1000 );
/*
 getbtns();
 int buttn =getbtns(); //*portD
 if (buttn){
   if(buttn&1){ //btn2
    mytime = (mytime & 0xff0f) | (getsw() <<4);
   }
   if(buttn&2){ //btn3
     mytime = (mytime & 0xf0ff) | (getsw() <<8);
   }
   if(buttn&4){ //btn4
     mytime = (mytime & 0x0fff) | (getsw() <<12);
   }
 }*/
}
