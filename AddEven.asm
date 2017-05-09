; AddEven.asm

; Authors: Denesh Canjimavadivel, Mohamed Elmekki, Jagmandeep Singh
; Student Number: 040 854 471, 040 847 947, 040 851 451
; Date: Apr 12 2017
;
; Purpose: Calculate the total number of even numbers
;
; Preconditions: A pointer to fist digit in SIN
;                The SIN length in ACC B
;
; Postcondition: Acculumulator A holds total number of even digits
;
;
;
Add_Even        cmpb    #$3
                ble     Loop
                ldaa    1,x-
                ldaa    1,x-
                adda    -1,x
                staa    -1,x
                decb
                cmpb    #$5
                bhi     Add_Even
                bra     increase




Loop            ldaa    1,x+
                ldaa    0,x
                adda    0,x
                staa    1,x+
                cmpa    #$9
                bhi     Add1
                decb
                cmpb    #$0
                beq     Increment
                bra     Loop

Add1            suba    #$9
                staa    -1,x
                decb
                cmpb    #$0
                beq     Increment
                bra     Loop

Increment       incb
                incb
                incb
                incb
                incb
                incb
                incb
                bra     Add_Even

Increase        ldaa    5,x+
                ldaa    -6,x
                rts


;------------------------------------------------
;               END AddEven                     -
;------------------------------------------------


;------------------------------------------------
;               END AddEven                     -
;------------------------------------------------


;------------------------------------------------
;               END AddEven                     -
;------------------------------------------------