; ToDigit.asm
; David Haley, 25 Mar 2017
;--------------------------------------
; ToDigit                             -
;    Converts from ASCII to Integer   -
;                                     -
;       Author: D. Haley, 25 Mar 2017 -
;                                     -
;       Precondition:                 -
;        X points to 1st digit of SIN -
;        B contains the length of SIN -
;                                     -
;       Postcondition:                -
;        - Value in A destroyed       -
;        - Value in B destroyed       -
;        - ASCIII values overwritten  -
;        - Value in X is address+1 of -
;          last digit of current SIN  -
;                                     -
;       Use: jsr ToDigit              -
;--------------------------------------
ToDigit ldaa    0,x     ; get ASCII value
        suba    #$30    ; convert to an integer
        staa    0,x     ; store integer
        inx             ; point to next value
        decb            ; one less value to do
        cmpb    #$0     ; Is this the last ASCII value?
        bne     ToDigit ; No, more to do
        rts             ; Yes, so we're done
; -------------------------------------
;         END of ToDigit              -
;--------------------------------------