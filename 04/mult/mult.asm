// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Mult.asm

// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)

  @sum
  M = 0           // initialize sum to 0
  @R0
  D = M
  @counter
  M = D           // counter = R0

  (LOOP)
  @counter
  D = M           // if counter = 0, break the loop
  @BREAK_LOOP
  D;JEQ

  @R1
  D = M
  @sum
  M = M + D       // sum = sum + R1
  @counter
  M = M - 1       // counter--
  @LOOP
  0;JMP

  (BREAK_LOOP)
  @sum
  D = M
  @R2
  M = D           // R2 = sum
  
  (END)
  @END
  0;JMP





