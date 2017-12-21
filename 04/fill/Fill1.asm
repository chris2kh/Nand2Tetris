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
   // observation    : the check of the keyboard occurs outside the loops
   //                : so you will see the screen color change always
   //                : bottom up

   (BEGINNING)                // infinite loop to listen to keyboard
   
   @24575
   D = A                      // 24575 = position of last 16 pixels
   @current_position
   M = D                      // initialize current_position to 24575

   @KBD
   D = M                      // get keyboard memory map register
   @WHITE_LOOP                // if that register is zero go to
   D;JEQ                      // white screen instructions
   
   (BLACK_LOOP)               // black screen instructions
   @current_position
   D = M
   @SCREEN                    // last visit to loop occurs when   
   D = D - A                  // current position = first pixel = 16384
   @BEGINNING                 // so loop breaks when D = 16383 -16384 = -1
   D;JLT
   @current_position
   A = M
   M = -1                     // turn on pixels at current_position
   @current_position
   M = M -1                   // update current_position before next loop
   @BLACK_LOOP
   0;JMP

   (WHITE_LOOP)               // white screen instructions
   @current_position
   D = M
   @SCREEN                    // last visit to loop occurs when
   D = D - A                  // current position = first pixel = 16384
   @BEGINNING                 // so loop breaks when D = 16383 -16384 = -1
   D;JLT
   @current_position
   A = M
   M = 0                      // turn off pixels at current_position
   @current_position
   M = M -1                   // update current_position before next loop
   @WHITE_LOOP
   0;JMP
