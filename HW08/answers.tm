<TeXmacs|1.99.2>

<style|generic>

<\body>
  <doc-data|<doc-title|HW08>|<doc-author|<author-data|<author-name|Yin
  Yu>|<\author-affiliation>
    <verbatim|PB13011038>
  </author-affiliation>>>>

  <\description>
    <item*|7.14>

    <\enumerate-alpha>
      <item>

      <\verbatim-code>
        x3000 1011 0000 0000 0010

        x3001 1111 0000 0010 0001

        x3002 1111 0000 0010 0101

        x3003 0000 0000 0010 0101
      </verbatim-code>

      <item>Replace <verbatim|STI> with <verbatim|LDI>.

      <item>When this program wants to halt as usual, it will go to location
      x25, which is accidentally the ASCII code of `%', and has been changed
      to R0. This will cause wired behavior.
    </enumerate-alpha>

    <item*|7.17>There won't be a linking problem. AGAIN here is a local
    symbol and will be transformed in the first pass. That means when it
    comes to linking process, there won't be a conflict. Unless that's not
    our intention (which means that we actually want a global AGAIN), this
    won't cause errors.

    <item*|7.18>

    <\verbatim-code>
      a: LDR R3, R1, #0

      b: NOT R3, R3

      c: ADD R3, R3, #1
    </verbatim-code>

    <item*|7.20>The former approach changes memory while running, which is
    dynamic, but the latter changes directly when the program is loaded,
    which is static.

    <item*|7.22>The program is as follows:

    <\verbatim-code>
      \ \ \ \ \ \ \ \ .ORIG \ \ x3000

      \ \ \ \ \ \ \ \ LD \ \ \ \ \ R6, NEGA

      \ \ \ \ \ \ \ \ IN

      \ \ \ \ \ \ \ \ ADD \ \ \ \ R1, R0, R6

      \ \ \ \ \ \ \ \ BRz \ \ \ \ T_ADD

      \ \ \ \ \ \ \ \ ADD \ \ \ \ R1, R1, #-11

      \ \ \ \ \ \ \ \ BRz \ \ \ \ T_LEA

      \ \ \ \ \ \ \ \ ADD \ \ \ \ R1, R1, #-2

      \ \ \ \ \ \ \ \ BRz \ \ \ \ T_NOT

      \ \ \ \ \ \ \ \ ADD \ \ \ \ R1, R1, #-5

      \ \ \ \ \ \ \ \ BRz \ \ \ \ T_ST

      \ \ \ \ \ \ \ \ JSR \ \ \ \ ERROR

      \;

      T_ADD \ \ LD \ \ \ \ \ R6, NEGA

      \ \ \ \ \ \ \ \ ADD \ \ \ \ R6, R6, #-3

      \ \ \ \ \ \ \ \ IN

      \ \ \ \ \ \ \ \ ADD \ \ \ \ R1, R0, R6

      \ \ \ \ \ \ \ \ BRnp \ \ \ ERROR

      \ \ \ \ \ \ \ \ IN

      \ \ \ \ \ \ \ \ ADD \ \ \ \ R1, R0, R6

      \ \ \ \ \ \ \ \ BRnp \ \ \ ERROR

      \ \ \ \ \ \ \ \ LD \ \ \ \ \ R6, ASCZERO

      \ \ \ \ \ \ \ \ AND \ \ \ \ R0, R0, #0

      \ \ \ \ \ \ \ \ ADD \ \ \ \ R0, R0, R6

      \ \ \ \ \ \ \ \ OUT

      \ \ \ \ \ \ \ \ OUT

      \ \ \ \ \ \ \ \ OUT

      \ \ \ \ \ \ \ \ ADD \ \ \ \ R0, R0, #1

      \ \ \ \ \ \ \ \ OUT

      \ \ \ \ \ \ \ \ HALT

      \;

      T_NOT \ \ LD \ \ \ \ \ R6, NEGA

      \ \ \ \ \ \ \ \ ADD \ \ \ \ R6, R6, #-14

      \ \ \ \ \ \ \ \ AND \ \ \ \ R5, R5, #0

      \ \ \ \ \ \ \ \ ADD \ \ \ \ R5, R6, #-5

      \ \ \ \ \ \ \ \ IN

      \ \ \ \ \ \ \ \ ADD \ \ \ \ R1, R0, R6

      \ \ \ \ \ \ \ \ BRnp \ \ \ ERROR

      \ \ \ \ \ \ \ \ IN

      \ \ \ \ \ \ \ \ ADD \ \ \ \ R1, R0, R5

      \ \ \ \ \ \ \ \ BRnp \ \ \ ERROR

      \ \ \ \ \ \ \ \ LD \ \ \ \ \ R6, ASCZERO

      \ \ \ \ \ \ \ \ AND \ \ \ \ R0, R0, #0

      \ \ \ \ \ \ \ \ ADD \ \ \ \ R0, R0, R6

      \ \ \ \ \ \ \ \ ADD \ \ \ \ R0, R0, #1

      \ \ \ \ \ \ \ \ OUT

      \ \ \ \ \ \ \ \ ADD \ \ \ \ R0, R0, #-1

      \ \ \ \ \ \ \ \ OUT

      \ \ \ \ \ \ \ \ OUT

      \ \ \ \ \ \ \ \ ADD \ \ \ \ R0, R0, #1

      \ \ \ \ \ \ \ \ OUT

      \ \ \ \ \ \ \ \ HALT

      \;

      T_ST \ \ \ LD \ \ \ \ \ R6, NEGA

      \ \ \ \ \ \ \ \ ADD \ \ \ \ R6, R6, #-16

      \ \ \ \ \ \ \ \ ADD \ \ \ \ R6, R6, #-3

      \ \ \ \ \ \ \ \ IN

      \ \ \ \ \ \ \ \ ADD \ \ \ \ R0, R0, R6

      \ \ \ \ \ \ \ \ BRnp \ \ \ ERROR

      \ \ \ \ \ \ \ \ LD \ \ \ \ \ R6, ASCZERO

      \ \ \ \ \ \ \ \ AND \ \ \ \ R0, R0, #0

      \ \ \ \ \ \ \ \ ADD \ \ \ \ R0, R0, R6

      \ \ \ \ \ \ \ \ OUT

      \ \ \ \ \ \ \ \ OUT

      \ \ \ \ \ \ \ \ ADD \ \ \ \ R0, R0, #1

      \ \ \ \ \ \ \ \ OUT

      \ \ \ \ \ \ \ \ OUT

      \ \ \ \ \ \ \ \ HALT

      \;

      T_LEA \ \ LD \ \ \ \ \ R6, NEGA

      \ \ \ \ \ \ \ \ AND \ \ \ \ R5, R5, #0

      \ \ \ \ \ \ \ \ ADD \ \ \ \ R5, R6, #-4

      \ \ \ \ \ \ \ \ IN

      \ \ \ \ \ \ \ \ ADD \ \ \ \ R0, R0, R5

      \ \ \ \ \ \ \ \ BRnp \ \ \ ERROR

      \ \ \ \ \ \ \ \ IN

      \ \ \ \ \ \ \ \ ADD \ \ \ \ R0, R0, R6

      \ \ \ \ \ \ \ \ BRnp \ \ \ ERROR

      \ \ \ \ \ \ \ \ LD \ \ \ \ \ R6, ASCZERO

      \ \ \ \ \ \ \ \ AND \ \ \ \ R0, R0, #0

      \ \ \ \ \ \ \ \ ADD \ \ \ \ R0, R0, R6

      \ \ \ \ \ \ \ \ ADD \ \ \ \ R0, R0, #1

      \ \ \ \ \ \ \ \ OUT

      \ \ \ \ \ \ \ \ OUT

      \ \ \ \ \ \ \ \ OUT

      \ \ \ \ \ \ \ \ ADD \ \ \ \ R0, R0, #-1

      \ \ \ \ \ \ \ \ OUT

      \ \ \ \ \ \ \ \ HALT

      \;

      ERROR \ \ LD \ \ \ \ \ R0, ERRCH

      \ \ \ \ \ \ \ \ OUT

      \ \ \ \ \ \ \ \ HALT

      \;

      ASCZERO .FILL \ \ x30

      NEGA \ \ \ .FILL \ \ xFFBF

      ERRCH \ \ .FILL \ \ x21

      \ \ \ \ \ \ \ \ .END
    </verbatim-code>

    <item*|7.24>The program should stop when R2 is zero instead of R3. We
    should move the instruction <verbatim|ADD R2, R2, #-1> right before
    <verbatim|BR> to fix this.
  </description>

  \;
</body>

<initial|<\collection>
</collection>>