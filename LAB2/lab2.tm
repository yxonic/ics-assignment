<TeXmacs|1.99.2>

<style|generic>

<\body>
  <doc-data|<doc-title|Lab 2: Report>|<doc-author|<author-data|<author-name|Yin
  Yu>|<\author-affiliation>
    <verbatim|PB13011038>
  </author-affiliation>>>>

  <section|Algorithm>

  For sorting 16 items, bubble sort or insertion sort are both appropriate. I
  used insertion sort here.

  <\render-code>
    L=15

    While L\<gtr\>=0:

    \ \ \ \ T=15-L

    \ \ \ \ check Memory[base+T] for his grade, increment related counter

    \ \ \ \ P=T

    \ \ \ \ While P\<gtr\>0:

    \ \ \ \ \ \ \ \ if Memory[base+P]\<gtr\>Memory[base+P-1]

    \ \ \ \ \ \ \ \ \ \ \ \ exchange these two items (in place)

    \ \ \ \ \ \ \ \ else

    \ \ \ \ \ \ \ \ \ \ \ \ the order is correct; break the loop
  </render-code>

  <section|Implementation Note>

  In practice, registers are really lacking. In general we need variables for
  base (used often), L (outer loop control), P (inner loop control) and two
  counters that cannot be used for other purposes, which take up 5 registers
  (in my program they are R0, R1, R2, R5, R6). General purpose register R3
  and R4 are still available. However inside inner loop, I must need another
  register. So I used R7. R7 is changed when jumping to other locations, for
  the purpose of jumping back later (if needed). Inside the inner loop R7 is
  not used. Therefore, though tricky, I can still use R7 here as a normal
  register, which solved the problem.

  The program is in the archive, with some readable comments added. Refer to
  <samp|sort.asm> for details.
</body>

<initial|<\collection>
</collection>>

<\references>
  <\collection>
    <associate|auto-1|<tuple|1|?|../../../.TeXmacs/texts/scratch/no_name_1.tm>>
    <associate|auto-2|<tuple|2|?|../../../.TeXmacs/texts/scratch/no_name_1.tm>>
  </collection>
</references>

<\auxiliary>
  <\collection>
    <\associate|toc>
      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|1<space|2spc>Algorithm>
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-1><vspace|0.5fn>

      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|2<space|2spc>Implementation
      Note> <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-2><vspace|0.5fn>
    </associate>
  </collection>
</auxiliary>