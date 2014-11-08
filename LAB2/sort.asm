        .ORIG x3000
        AND     R1, R1, #0      ; outer loop var
        AND     R2, R2, #0      ; inner loop var
        AND     R5, R5, #0      ; for grade A count
        AND     R6, R6, #0      ; for grade B count
        LD      R0, head        ; memory location x4000
        ADD     R1, R1, #15
;;; Insertion Sort (counts students at the same time)
loop    BRn     finish          ; outer loop. break when R1<0
        NOT     R2, R1
        ADD     R2, R2, #1
        ADD     R2, R2, #15     ; R2=15-R1 (current location to be inserted)
        ADD     R3, R0, R2
        LDR     R3, R3, #0      ; check for this person's grade
        LD      R4, neg85       
        ADD     R4, R3, R4
        BRn     skip1
        ADD     R5, R5, #1
        JSR     skip2
skip1   LD      R4, neg75
        ADD     R4, R3, R4
        BRn     skip2
        ADD     R6, R6, #1
skip2   ADD     R2, R2, #0      
inner   BRz     break           ; inner loop, break if reached front
        ADD     R3, R0, R2      ; R3 is current location
        LDR     R7, R3, #0      ; CAUTION: use R7 before any jumps!
        LDR     R4, R3, #-1     ; [ ] [R4] [R7] [ ] ...
        NOT     R3, R4
        ADD     R3, R3, #1      ; R3=-R4
        ADD     R3, R3, R7      ; R3=R7-R4
        BRnz    break           ; if R7<=R4 then everything is ok
        ADD     R3, R0, R2      ; else exchange R4, R7 (in memory)
        STR     R4, R3, #0
        STR     R7, R3, #-1
        ADD     R2, R2, #-1     ; move current position backwards
        JSR     inner
break   ADD     R1, R1, #-1     ; next position
        JSR     loop
finish  LD      R1, offset      ; output counts
        ADD     R0, R0, R1
        STR     R5, R0, #0
        STR     R6, R0, #1
        HALT        
head    .FILL   x4000
neg85   .FILL   xFFAA        
neg75   .FILL   xFFB4
offset  .FILL   x0100
        .END
