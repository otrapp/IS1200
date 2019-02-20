/* mipslabwork.c

   This file written 2015 by F Lundevall
   Updated 2017-04-21 by F Lundevall

   This file should be changed by YOU! So you must
   add comment(s) here with your name(s) and date(s):

   This file modified 2017-04-31 by Ture Teknolog

   For copyright and licensing, see file COPYING */

#include <stdint.h>   /* Declarations of uint_32 and the like */
#include <pic32mx.h>  /* Declarations of system-specific addresses etc */
#include "mipslab.h"  /* Declatations for these labs */

int mytime = 0x5957;

volatile int *initE;
volatile int *portE;
int tickCount;
int sw;
char textstring[] = "text, more text, and even more text!";

/* Interrupt Service Routine */
void user_isr( void )
{
  return;
}

/* Lab-specific initialization goes here */
void labinit( void )
{
  TRISD = TRISD | 0x0fe0;
  tickCount = 0;
  initE = (int*) 0xbf886100;
  *initE = *initE & 0xffffff00;
  //*initE &= ~0xff00;
  portE = (int*) 0xbf886110;
/*  *portE = portE;
  *portE &= ~0xff00;*/

  return;
}

/* This function is called repetitively from the main program */
void labwork( void )
{
  delay( 1000 );
  time2string( textstring, mytime );
  display_string( 3, textstring );
  display_update();
  tick( &mytime );
  tickCount++;
  *portE = (tickCount) | 0xf00;
  display_image(96, icon);

  int buttn = getbtns();
  sw = getsw();
  if (buttn)
  {
    if(buttn&1) //btn2
    { mytime = (mytime & 0xff0f) | (getsw() <<4);}

    if(buttn&2) //btn3
    {mytime = (mytime & 0xf0ff) | (getsw() <<8);}


    if(buttn&4) //btn4
    {mytime = (mytime & 0x0fff) | (getsw() <<12);}
 /*
    if(buttn==3) //btn2&3
    {mytime = ((mytime & 0xf00f) | (getsw() <<4) | (getsw() <<8));}


    if(buttn==5) //btn4&2
    {mytime = ((mytime & 0x0f0f) | (getsw() <<12) | (getsw()<<4));}

    if(buttn==6) //btn4&3
    {mytime = ((mytime & 0x00ff) | (getsw() <<12) | (getsw() <<8));}

    if(buttn==7) //all 3
    {mytime = ((mytime & 0x000f) | (getsw() <<12) | (getsw() <<8) | (getsw() <<4));}
  */  
  }
}
