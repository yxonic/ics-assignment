<TeXmacs|1.99.2>

<style|tmarticle>

<\body>
  <doc-data|<doc-title|HW07>|<doc-author|<author-data|<author-name|Yin
  Yu>|<\author-affiliation>
    <verbatim|<verbatim|PB13011038>>
  </author-affiliation>>>>

  <\description>
    <item*|5.32>Last instruction (ADD R0, R0, #-1) will set N = 1, Z = 0, P =
    0.

    <item*|5.40>A suggests whether PC is to be set to another place given by
    following bits. If A is 1, it means that the condition of BR satisfies.

    <item*|6.16>The program is as follows:

    <\verbatim-code>
      \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ ; PC=x3000, set
      MAR=x3000

      x3000 0010 000 0000100 \ \ \ \ \ ; LD R0,x3005, MAR=x3005, PC+1,
      MAR=x3001 \ \ \ 

      x3001 0001 000 000 1 00001 \ ; ADD R0, R0, #1, PC+1, MAR=x3002

      x3002 1011 000 0000011 \ \ \ \ \ ; STI R0,x3006,
      MAR=x3006-\<gtr\>x4001-\<gtr\>3003

      x3003 1111 0000 0010 0001 \ \ ; TRAP x21, MAR=x0021

      x3004 1111 0000 0010 0101 \ \ ; unreachable

      x3005 0000 0000 0011 0000 \ \ ; will be loaded to R0 by LD

      x3006 0100 0000 0000 0001 \ \ ; x4001, will be loaded into MAR by STI
    </verbatim-code>

    <item*|7.1><verbatim|1010 011 111111110>

    <item*|7.5>

    <\enumerate-alpha>
      <item>Let mem[RESULT] = mem[M0] * mem[M1]

      <item>x200C
    </enumerate-alpha>

    <item*|7.9>It suggests the assembler that the program (written in
    assembly language) is finished and there is no need to read further and
    translate. On the other hand, HALT is an instruction that terminates the
    machine. .END won't do anything to the computer itself, because it's not
    an instruction like HALT is. After assembling process, .END will
    completely disappear.

    <item*|7.10>#30 can't be represented in 5 bits under 2's-complement
    representation. The error can be detected when the code is assembled.

    <item*|7.13>The program is as follows:

    <\verbatim-code>
      \ \ \ \ \ \ \ \ .ORIG \ \ x3000

      \ \ \ \ \ \ \ \ LD \ \ \ \ \ R6, ASCZERO \ \ \ \ ; load `0' for output

      \ \ \ \ \ \ \ \ IN \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ ; input
      first char

      \ \ \ \ \ \ \ \ ADD \ \ \ \ R2, R0, #0 \ \ \ \ \ ; store to R2

      \ \ \ \ \ \ \ \ IN \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ ; input
      first digit (call it A)

      \ \ \ \ \ \ \ \ ST \ \ \ \ \ R0, CHAR1 \ \ \ \ \ \ ; store first digit

      \ \ \ \ \ \ \ \ IN \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ ; input
      second digit (call it B)

      \ \ \ \ \ \ \ \ ST \ \ \ \ \ R0, CHAR2 \ \ \ \ \ \ ; store second digit

      \ \ \ \ \ \ \ \ LD \ \ \ \ \ R1, COND \ \ \ \ \ \ \ ; R1 \<less\>- -x23
      (ASCII code of `#')

      \ \ \ \ \ \ \ \ ADD \ \ \ \ R1, R1, R2 \ \ \ \ \ ; R1 = 0 if got `#'

      \ \ \ \ \ \ \ \ BRnp \ \ \ HEX \ \ \ \ \ \ \ \ \ \ \ \ ; goto HEX if
      not `#'

      \ \ \ \ \ \ \ \ 

      DEC \ \ \ \ LD \ \ \ \ \ R1, CHAR2 \ \ \ \ \ \ ; load B to R1

      \ \ \ \ \ \ \ \ LD \ \ \ \ \ R3, NZERO \ \ \ \ \ \ ; for char to digit

      \ \ \ \ \ \ \ \ ADD \ \ \ \ R1, R1, R3 \ \ \ \ \ ; now R1 is B

      \ \ \ \ \ \ \ \ LD \ \ \ \ \ R2, CHAR1 \ \ \ \ \ \ ; load A to R2

      \ \ \ \ \ \ \ \ ADD \ \ \ \ R2, R2, R3 \ \ \ \ \ ; char to digit

      \ \ \ \ \ \ \ \ AND \ \ \ \ R3, R3, #0 \ \ \ \ \ ; clear R3

      \ \ \ \ \ \ \ \ ADD \ \ \ \ R3, R2, R2 \ \ \ \ \ ; R3 \<less\>- 2 * A

      \ \ \ \ \ \ \ \ ADD \ \ \ \ R4, R3, R3 \ \ \ \ \ ; R4 \<less\>- 4 * A

      \ \ \ \ \ \ \ \ ADD \ \ \ \ R4, R4, R4 \ \ \ \ \ ; R4 \<less\>- 8 * A

      \ \ \ \ \ \ \ \ ADD \ \ \ \ R2, R3, R4 \ \ \ \ \ ; R2 \<less\>- 2 * A +
      8 * A = 10 * A

      \ \ \ \ \ \ \ \ ADD \ \ \ \ R1, R1, R2 \ \ \ \ \ ; now R1 = 10 * A + B

      \ \ \ \ \ \ \ \ JSR \ \ \ \ PRINT \ \ \ \ \ \ \ \ \ \ ; to PRINT

      \ \ \ \ \ \ \ \ 

      HEX \ \ \ \ LD \ \ \ \ \ R1, CHAR2 \ \ \ \ \ \ ; load B to R1

      \ \ \ \ \ \ \ \ LD \ \ \ \ \ R3, NZERO \ \ \ \ \ \ ; for char to digit

      \ \ \ \ \ \ \ \ ADD \ \ \ \ R1, R1, R3 \ \ \ \ \ ; now R1 is B

      \ \ \ \ \ \ \ \ ADD \ \ \ \ R4, R1, #-9 \ \ \ \ ; R4 \<less\>- R1 - 9

      \ \ \ \ \ \ \ \ BRnz \ \ \ SKIP1 \ \ \ \ \ \ \ \ \ \ ; see whether R1
      \<gtr\> 9

      \ \ \ \ \ \ \ \ ADD \ \ \ \ R1, R1, #-7 \ \ \ \ ; if R1 \<gtr\> 9,
      change it to the correct number

      SKIP1 \ \ LD \ \ \ \ \ R2, CHAR1 \ \ \ \ \ \ ; load A to R2

      \ \ \ \ \ \ \ \ ADD \ \ \ \ R2, R2, R3 \ \ \ \ \ ; same kind of stuff

      \ \ \ \ \ \ \ \ ADD \ \ \ \ R4, R2, #-9 \ \ \ \ ;

      \ \ \ \ \ \ \ \ BRnz \ \ \ SKIP2 \ \ \ \ \ \ \ \ \ \ ;

      \ \ \ \ \ \ \ \ ADD \ \ \ \ R2, R2, #-7 \ \ \ \ ; now R2 is A

      SKIP2 \ \ ADD \ \ \ \ R2, R2, R2 \ \ \ \ \ ; R2 \<less\>- 2 * A

      \ \ \ \ \ \ \ \ ADD \ \ \ \ R2, R2, R2 \ \ \ \ \ ; R2 \<less\>- 4 * A

      \ \ \ \ \ \ \ \ ADD \ \ \ \ R2, R2, R2 \ \ \ \ \ ; R2 \<less\>- 8 * A

      \ \ \ \ \ \ \ \ ADD \ \ \ \ R2, R2, R2 \ \ \ \ \ ; R2 \<less\>- 16 * A

      \ \ \ \ \ \ \ \ ADD \ \ \ \ R1, R1, R2 \ \ \ \ \ ; now R1 = 16 * A + B

      \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ ; to
      PRINT

      PRINT \ \ AND \ \ \ \ R5, R5, #0 \ \ \ \ \ ; R5 as loop variable

      \ \ \ \ \ \ \ \ ADD \ \ \ \ R5, R5, #7 \ \ \ \ \ ; skip eight 0's

      STRIP \ \ ADD \ \ \ \ R1, R1, R1 \ \ \ \ \ ; shift left

      \ \ \ \ \ \ \ \ ADD \ \ \ \ R5, R5, #-1 \ \ \ \ ; decrease R5

      \ \ \ \ \ \ \ \ BRzp \ \ \ STRIP \ \ \ \ \ \ \ \ \ \ ; skipped for 8
      times?

      \ \ \ \ \ \ \ \ AND \ \ \ \ R5, R5, #0 \ \ \ \ \ ; for next iteration

      \ \ \ \ \ \ \ \ ADD \ \ \ \ R5, R5, #7 \ \ \ \ \ ; print eight bits

      LOOP \ \ \ BRn \ \ \ \ FIN \ \ \ \ \ \ \ \ \ \ \ \ ; if printed 8 bits
      then halt

      \ \ \ \ \ \ \ \ ADD \ \ \ \ R1, R1, #0 \ \ \ \ \ ; set PSR

      \ \ \ \ \ \ \ \ BRn \ \ \ \ OUT1 \ \ \ \ \ \ \ \ \ \ \ ; if first digit
      is 1 then print 1

      OUT0 \ \ \ AND \ \ \ \ R0, R0, #0 \ \ \ \ \ ; else print 0

      \ \ \ \ \ \ \ \ ADD \ \ \ \ R0, R0, R6 \ \ \ \ \ ; R6 is ascii 0

      \ \ \ \ \ \ \ \ OUT \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ ; print it

      \ \ \ \ \ \ \ \ ADD \ \ \ \ R1, R1, R1 \ \ \ \ \ ; shift left

      \ \ \ \ \ \ \ \ ADD \ \ \ \ R5, R5, #-1 \ \ \ \ ; decrease counter

      \ \ \ \ \ \ \ \ JSR \ \ \ \ LOOP \ \ \ \ \ \ \ \ \ \ \ ; loop

      OUT1 \ \ \ AND \ \ \ \ R0, R0, #0 \ \ \ \ \ ; same kind of stuff

      \ \ \ \ \ \ \ \ ADD \ \ \ \ R0, R0, R6 \ \ \ \ \ ;\ 

      \ \ \ \ \ \ \ \ ADD \ \ \ \ R0, R0, #1 \ \ \ \ \ ;

      \ \ \ \ \ \ \ \ OUT \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ ;

      \ \ \ \ \ \ \ \ ADD \ \ \ \ R1, R1, R1 \ \ \ \ \ ;

      \ \ \ \ \ \ \ \ ADD \ \ \ \ R5, R5, #-1 \ \ \ \ ;

      \ \ \ \ \ \ \ \ JSR \ \ \ \ LOOP \ \ \ \ \ \ \ \ \ \ \ ; loop

      \;

      FIN \ \ \ \ HALT

      \;

      COND \ \ \ .FILL \ \ xFFDD \ \ \ \ \ \ \ \ \ \ ; -x23

      ASCZERO .FILL \ \ x30 \ \ \ \ \ \ \ \ \ \ \ \ ; ASCII code of `0'

      NZERO \ \ .FILL \ \ xFFD0

      CHAR1 \ \ .FILL \ \ x0

      CHAR2 \ \ .FILL \ \ x0

      \ \ \ \ \ \ \ \ .END
    </verbatim-code>
  </description>

  The program can also be found in the archieve (<verbatim|conv.asm>).
</body>

<initial|<\collection>
</collection>>