; AddOdd.asm

; Authors: Denesh Canjimavadivel, Mohamed Elmekki, Jagmandeep Singh
; Student Number: 040 854 471, 040 847 947, 040 851 451
; Date: Apr 12 2017
;
; Purpose:  Adding odd numbers
;
; Preconditions:  X points to 1st digit of SIN
;                 B contains the length of SIN
;
; Postcondition:
;
;
;

Add_Odd         ldaa    0,x
                adda    2,x
                staa    2,x
                ldaa    2,x+
                decb
                cmpb    #$1
                bhi     Add_Odd
                bra     position

position        ldaa    6,x-
                ldaa    6,x
                rts

;--------------------------------------
;           END AddOdd                -
;--------------------------------------



