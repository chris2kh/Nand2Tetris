// This file is part of www.nand2tetris.org
// and ithe book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed. 
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.

   // strategy       : manipulate the last 16 pixels of the screen and loop
   //                  backwards until first 16 pixels  
   // why backwards? : you write less code and use less registers
   // observation    : the check of the keyboard occurs inside the loop
   //                : so you will see the screen color change starting
   //                : in whatever position the loop was in at that time

   (BEGINNING)                // infinite loop to listen to keyboard
   
   @24575                     // 24575 = position of last 16 pixels
   D = A
   @current_position
   M = D                      // initialize current_position to 24575

   (LOOP)               
   @SCREEN
   D = D - A                  // last visit to loop occurs when
   @BEGINNING                 // current_position = first pixel = 16384
   D;JLT                      // so loop breaks when D = 16383 - 16384 = -1  

   @KBD
   D = M                      // get keyboard memory map register
   @IF_WHITE                  // if that register is zero go to
   D;JEQ                      // white screen instructions

                              // black instructions
   @current_position
   A = M
   M = -1                     // turn on pixels at current_position
   @AFTER_WHITE               // skip white instructions
   0;JMP

   (IF_WHITE)
   @current_position
   A = M
   M = 0                      // turn off pixels at current_position

   (AFTER_WHITE)
   @current_position
   M = M - 1                  // update current_position before next loop
   D = M                      // store current_position in D
   @LOOP
   0;JMP

