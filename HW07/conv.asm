        .ORIG   x3000
        LD      R6, ASCZERO     ; load `0' for output
        IN                      ; input first char
        ADD     R2, R0, #0      ; store to R2
        IN                      ; input first digit (call it A)
        ST      R0, CHAR1       ; store first digit
        IN                      ; input second digit (call it B)
        ST      R0, CHAR2       ; store second digit
        LD      R1, COND        ; R1 <- -x23 (ASCII code of `#')
        ADD     R1, R1, R2      ; R1 = 0 if got `#'
        BRnp    HEX             ; goto HEX if not `#'
        
DEC     LD      R1, CHAR2       ; load B to R1
        LD      R3, NZERO       ; for char to digit
        ADD     R1, R1, R3      ; now R1 is B
        LD      R2, CHAR1       ; load A to R2
        ADD     R2, R2, R3      ; char to digit
        AND     R3, R3, #0      ; clear R3
        ADD     R3, R2, R2      ; R3 <- 2 * A
        ADD     R4, R3, R3      ; R4 <- 4 * A
        ADD     R4, R4, R4      ; R4 <- 8 * A
        ADD     R2, R3, R4      ; R2 <- 2 * A + 8 * A = 10 * A
        ADD     R1, R1, R2      ; now R1 = 10 * A + B
        JSR     PRINT           ; to PRINT
        
HEX     LD      R1, CHAR2       ; load B to R1
        LD      R3, NZERO       ; for char to digit
        ADD     R1, R1, R3      ; now R1 is B
        ADD     R4, R1, #-9     ; R4 <- R1 - 9
        BRnz    SKIP1           ; see whether R1 > 9
        ADD     R1, R1, #-7     ; if R1 > 9, change it to the correct number
SKIP1   LD      R2, CHAR1       ; load A to R2
        ADD     R2, R2, R3      ; same kind of stuff
        ADD     R4, R2, #-9     ;
        BRnz    SKIP2           ;
        ADD     R2, R2, #-7     ; now R2 is A
SKIP2   ADD     R2, R2, R2      ; R2 <- 2 * A
        ADD     R2, R2, R2      ; R2 <- 4 * A
        ADD     R2, R2, R2      ; R2 <- 8 * A
        ADD     R2, R2, R2      ; R2 <- 16 * A
        ADD     R1, R1, R2      ; now R1 = 16 * A + B
                                ; to PRINT
PRINT   AND     R5, R5, #0      ; R5 as loop variable
        ADD     R5, R5, #7      ; skip eight 0's
STRIP   ADD     R1, R1, R1      ; shift left
        ADD     R5, R5, #-1     ; decrease R5
        BRzp    STRIP           ; skipped for 8 times?
        AND     R5, R5, #0      ; for next iteration
        ADD     R5, R5, #7      ; print eight bits
LOOP    BRn     FIN             ; if printed 8 bits then halt
        ADD     R1, R1, #0      ; set PSR
        BRn     OUT1            ; if first digit is 1 then print 1
OUT0    AND     R0, R0, #0      ; else print 0
        ADD     R0, R0, R6      ; R6 is ascii 0
        OUT                     ; print it
        ADD     R1, R1, R1      ; shift left
        ADD     R5, R5, #-1     ; decrease counter
        JSR     LOOP            ; loop
OUT1    AND     R0, R0, #0      ; same kind of stuff
        ADD     R0, R0, R6      ; 
        ADD     R0, R0, #1      ;
        OUT                     ;
        ADD     R1, R1, R1      ;
        ADD     R5, R5, #-1     ;
        JSR     LOOP            ; loop

FIN     HALT

COND    .FILL   xFFDD           ; -x23
ASCZERO .FILL   x30             ; ASCII code of `0'
NZERO   .FILL   xFFD0
CHAR1   .FILL   x0
CHAR2   .FILL   x0
        .END
