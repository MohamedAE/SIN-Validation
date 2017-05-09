; SIN_Validation.asm
#include c:\68hcs12\registers.inc

; Authors: Denesh Canjimavadivel, Mohamed Elmekki, Jagmandeep Singh
; Student Number: 040 854 471, 040 847 947, 040 851 451
; Date: Apr 12 2017

; Purpose:      Social Insurance Number Validation

; Memory Map
STORAGE1        equ     $1000                   ; Storage starts here for original SINs
PROGRAMSTART    equ     $2000                   ; Executable code starts here

ODDEVENRESULTS  equ     $1030                   ; Address for storing results of AddOdd
                                                ; and AddEven results. Primarily included
                                                ; for debugging purposes
FINALRESULTS    equ     $1032                   ; Final numbers of valid and invalid SINs

; Flags
INVALIDSIN      equ     $0                      ; Invalid SIN indicator
VALIDSIN        equ     $1                      ; Valid SIN indicator

; SIN Constants
LEN             equ     7                       ; hardcoded array size - 7 elements in SIN.txt
NUMBEROFSINS    equ     6                       ; Six SINs to process
NUMODDELEMENTS  equ     4                       ; Four odd numbered elements in a SIN
NUMEVENELEMENTS equ     3                       ; Three even numbered elements in a SIN


; Hex_Display Subroutine Values (Check Lecture Notes for values to use here)
DIGIT_ONE_HEX_DISPLAY   equ        $0B                ; Code to use HEX Display 2nd from the right
DIGIT_TWO_HEX_DISPLAY   equ     $0D                ; Code to use HEX Display 3rd from the right

; Delay_ms Subroutine Values

DVALUE  equ     #255     ; Delay value (base 10) 0 - 255 ms
                          ; 125 = 1/8 second

; SIN numbers to validate are stored commencing at $1000;
; Note that these numbers are supplied as a string, so they will have to be
; converted to digits before processing. You can simply overwrite the original
; string with its decimal equivalent.

                    org     STORAGE1           ; NOTE: Cannot put label SINs on the org line
SINs                                           ; substitute the appropriate file name here.
                                               ; Valid/Invalid
;#include TEST_SINs.txt

;#include WED_11_1_LAB_GROUP.txt
#include WED_1_3_LAB_GROUP.txt
;#include FRI_8_10_LAB_GROUP.txt

                    org     ODDEVENRESULTS
; Scratch Pad area for intermediate results
OddSum          ds      1                       ; Results of adding odd digits in SIN
EvenSum         ds      1                       ; Results of adding even digits in SIN

; Results of validation stored here and then retrieve for display
                org     FINALRESULTS
ValidResult     ds      1                       ; Count of Valid SINs processed
InvalidResult   ds      1                       ; Count of Invalid SINs processed

                org     ProgramStart
Main                                            ; Configuration
                lds     #ProgramStart           ; Stack used to protect values
ConvertSINs     ldx     #SINs                   ; point to first digit of first SIN
                clra                            ; loop counter
ConvertLoop     psha                            ; Save Loop Counter because ToDigit
                                                ; destroys A
                ldab    #LEN                    ; SINS length
                jsr     ToDigit                 ; Convert from ASCII to Integer
                pula                            ; retrieve Loop Counter
                inca                            ; setup to loop again
                cmpa    #NUMBEROFSINS           ; Are we done?
                bne     ConvertLoop             ; No, contiue converting
                                                ; Yes
; use the above CONSTANTS and code in your solution.
; remainder of Sin_Validation follows, which you are to write...
                ldaa    #$0
                staa    InvalidResult           ; Store invalid result flag
                staa    ValidResult             ; Store valid result flag
                ldx     #SINs
                tfr     X,Y
                clra

Loop1           psha
                ldab    #NUMODDELEMENTS
                jsr     Add_Odd
                staa    OddSum                        ; Store total number of odd numbers
                ldab    #NUMEVENELEMENTS
                jsr     Add_Even
                staa    EvenSum                 ; Store total number of even numbers
                ldab    OddSum
                staa    OddSum
                jsr     Validate
                cmpa    #VALIDSIN               ; Check validity of SIN
                beq     Valid                        ; If valid, end loop
                inc     InvalidResult           ; If invalid, prepare to loop again
                pula
                inca                            ; Prepare to loop again
                cmpa    #NUMBEROFSINS
                bne     GetSIN
                bra     Finished

Loop2           pula
                inca                            ; Prepare to loop again
                cmpa    #NUMBEROFSINS
                beq     Finished
GetSIN	        ldab    #LEN
                leay    B,Y                        ; Point to next digit in SIN sequence
                tfr     Y,X                     ; Point to first digit in SIN
                cpy     #NUMBEROFSINS		; Check if we have reached the end of the SIN
                beq     Finished
                bra     Loop1

Valid		inc     ValidResult
                bra     Loop2
; *************** Use the folowing code in your solution. **************

;***************** Do NOT change any of the following code *************
Finished        jsr     Config_HEX_Displays
Answer          ldaa    ValidResult             ; Number of Valid SINs
                ldab    #DIGIT_TWO_HEX_DISPLAY
                jsr     Hex_Display
                jsr     Delay_ms
                ldaa    InvalidResult           ; Number of Invalid SINs
                ldab    #DIGIT_ONE_HEX_DISPLAY
                jsr     Hex_Display
                jsr     Delay_ms
                bra     Answer                  ; endless loop to display answer
                end

#include ToDigit.asm
#include AddOdd.asm
#include AddEven.asm
#include Validate.asm
#include Hex_Display.asm
#include C:\68HCS12\Lib\Config_HEX_Displays.asm
#include C:\68HCS12\Lib\Delay_ms.asm
;************************* No Code Past Here ****************************
                end