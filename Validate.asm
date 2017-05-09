Validate
                aba                     ; Adding the ODDs and EVENs
                tfr     A,B            ; Prepare ACC D for integer division
                clra
                ldx     #10
                idiv                    ; Integer division
                cpd     #$00            ; Copy remainder to memory
                beq     StoreValid
                ldaa    #$0             ; Not valid if indivisible by 10
                rts

StoreValid      ldaa    #$1             ; Valid
                rts