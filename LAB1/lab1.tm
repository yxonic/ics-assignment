<TeXmacs|1.99.2>

<style|<tuple|llncs|british>>

<\body>
  <doc-data|<doc-title|Lab 1: Report>|<doc-author|<\author-data|<author-name|Yin
  Yu (<verbatim|PB13011038>)>>
    \ \ ()
  </author-data>>>

  <section|Solving the Problem>

  <\description-compact>
    <item*|Problem>Count the number of ones in a 16-bit word.
  </description-compact>

  Obviously to solve this problem, we need a way to implement loop. The
  pseudo code is like this:

  <\render-code>
    INPUT n

    cnt = 0

    while (n != 0):

    \ \ \ \ if (n begins with 1):

    \ \ \ \ \ \ \ \ cnt = cnt + 1

    \ \ \ \ n shift left for 1 bit

    OUTPUT cnt
  </render-code>

  Shift left can be achieved by adding n to itself. To check whether n begins
  with 1, consider 2's-complement representation of n: n begins with 1 iff n
  is negative.

  Therefore, here we need two registers, one for n, one for the output. Using
  <verbatim|BR> we can easily decide which instruction to execute according
  to n.

  Now here is the program in assembly language:

  <\verbatim-code>
    \ \ \ \ \ \ \ \ .ORIG x3000

    \ \ \ \ \ \ \ \ AND R2,R2,x0 \ ; clear R2

    \ \ \ \ \ \ \ \ LEA R3,x00FE \ ; load R3 with the location

    \ \ \ \ \ \ \ \ LDR R1,R3,x0 \ ; load input from memory

    LOOP \ \ \ BRzp SKIP \ \ \ \ ; check R1, skip incrementing

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ ; \ \ if R1 doesn't start
    with 1

    \ \ \ \ \ \ \ \ ADD R2,R2,x1 \ ; increment R2 (the counter)

    SKIP \ \ \ ADD R1,R1,R1 \ ; shift left

    \ \ \ \ \ \ \ \ BRnp LOOP \ \ \ \ ; if R1 is not 0, go back to LOOP

    \ \ \ \ \ \ \ \ STR R2,R3,x1 \ ; finished. write to memory

    \ \ \ \ \ \ \ \ HALT

    \ \ \ \ \ \ \ \ .END
  </verbatim-code>

  This program can be easily converted to LC3 binary code, by hand or by
  <verbatim|lc3as>. The binary code is show here:

  <\verbatim-code>
    0011 0000 0000 0000

    0101 010 010 1 00000

    1110 011 0 1111 1110

    0110 001 011 000000

    0000 011 000000001

    0001 010 010 1 00001

    0001 001 001 000 001

    0000 101 111111100

    0111 010 011 000001

    1111 000000100101
  </verbatim-code>

  <section|Using <verbatim|lc3tools>>

  Using UNIX version of <verbatim|lc3tools> is quite easy. The GUI tool is
  quite straightforward so I won't talk about it much.

  The command line version: <verbatim|lc3sim>, is also easy to use. Much like
  a debugging tool (eg. <verbatim|gdb>), this simple program provides
  <verbatim|file> command for loading file, <verbatim|break>,
  <verbatim|continue>, <verbatim|finish>, <verbatim|next>, <verbatim|step>
  for execution control, <verbatim|list>, <verbatim|translate>,
  <verbatim|printregs> for printing current state, and <verbatim|memory>,
  <verbatim|register> to set memory of register.

  For this program, I tested several numbers including x0000, x1111, xFFFF,
  and some other random numbers. Program is able to generate the correct
  result and halt.

  <section|Another Version with <verbatim|SHR>>

  In fact, on a more powerful computer with <verbatim|SHR> (right shift),
  this problem can be solved without a loop.

  <\verbatim-code>
    x = (x and x5555) + ((x shr 1) and x5555)

    x = (x and x3333) + ((x shr 2) and x3333)

    x = (x and x0F0F) + ((x shr 4) and x0F0F)

    x = (x and x00FF) + ((x shr 8) and x00FF)
  </verbatim-code>

  This program is not that clear as the previous version, but\ 

  Of course this doesn't mean that such kind of computer can do more job than
  LC3, but it does show that with more operation supported, problems can be
  solved easier or faster.
</body>

<\references>
  <\collection>
    <associate|auto-1|<tuple|1|?>>
    <associate|auto-2|<tuple|2|?>>
    <associate|auto-3|<tuple|3|?>>
    <associate|auto-4|<tuple|4|?>>
  </collection>
</references>

<\auxiliary>
  <\collection>
    <\associate|toc>
      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|1<space|2spc>Solving
      the Problem> <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-1><vspace|0.5fn>

      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|2<space|2spc>The
      Program> <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-2><vspace|0.5fn>

      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|3<space|2spc>Using
      <with|font-family|<quote|tt>|language|<quote|verbatim>|lc3tools>>
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-3><vspace|0.5fn>
    </associate>
  </collection>
</auxiliary>