        .ORIG x3000
        AND R2,R2,x0
        LEA R3,x00FE
        LDR R1,R3,x0
LOOP    BRzp SKIP
        ADD R2,R2,x1
SKIP    ADD R1,R1,R1
        BRnp LOOP
        STR R2,R3,x1
        HALT
        .END
