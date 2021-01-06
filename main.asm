include    c:\Irvine\Irvine32.inc
includelib c:\Irvine\irvine32.lib
includelib c:\Irvine\kernel32.lib
includelib y:\masm32\lib\user32.lib


.DATA

    arrayptr    DWORD OFFSET array
    array       BYTE 4096 DUP (?)
    mes1        BYTE 10, "1-add number 2-display all numbers 3-remove a number 4-search for a number 5-quit", 0
    check byte 0,0
    ;mes1        BYTE 10, "press 1 to add an element, 2 to print, 3 to quit    ", 0
    yourName  byte "Name : ",0
    number byte "Number : ",0
    mesToTakeName byte "Enter Your Name : ",0
    mesToMaxNumber byte "Max Numbers !!!",0
    mesToTakeNumber byte "Enter Your Number : ",0
    msgMoreNumber byte "More Numbers? (y) or ??",0
    maxNum byte 0,0
    zeros  byte ?
    eqaa byte "++",0

      



.CODE


readin PROC
    mov    maxNum , 0
    mov edx, arrayptr           ; Argument for ReadString: Pointer to memory
    mov al , eqaa
    mov  [edx], al
    lea edx, [edx+1+1]        ; EDX += EAX + 1
    mov arrayptr, edx           ; New pointer, points to the byte where the next string should 
    lea   edx, mesToTakeName
	call  writeString
	call	CrLf
    mov edx, arrayptr           ; Argument for ReadString: Pointer to memory
    mov ecx, 20                 ; Argument for ReadString: maximal number of chars
    call ReadString             ; Doesn't change EDX
    test eax, eax               ; EAX == 0 (got no string)
    jz done                     ; Yes: don't store a new arrayptr
    lea edx, [edx+eax+1]        ; EDX += EAX + 1
    mov arrayptr, edx           ; New pointer, points to the byte where the next string should begin
    take_number:
            cmp   maxNum , 3
            je    maxNumFunc
            lea   edx, mesToTakeNumber
	        call  writeString
	        call	CrLf
            mov edx, arrayptr           ; Argument for ReadString: Pointer to memory
            mov ecx, 15                 ; Argument for ReadString: maximal number of chars
            call ReadString             ; Doesn't change EDX
            inc     maxNum
            test eax, eax               ; EAX == 0 (got no string)
            jz done                     ; Yes: don't store a new arrayptr
            lea edx, [edx+eax+1]        ; EDX += EAX + 1
            mov arrayptr, edx           ; New pointer, points to the byte where the next string should begin
            lea edx, msgMoreNumber
			call writestring
			call	CrLf
			call readchar
			mov check , al
			cmp check , 79h
			je  take_number
			jmp done
 
 filling: 
            mov edx, arrayptr           ; Argument for ReadString: Pointer to memory
            mov al , eqaa
            mov  [edx], al
            lea edx, [edx+1+1]        ; EDX += EAX + 1
            mov arrayptr, edx           ; New pointer, points to the byte where the next string should begin
			jmp done

maxNumFunc:
            lea   edx, mesToMaxNumber
	        call  writeString
	        call	CrLf
	        call	CrLf
            mov    maxNum , 0
            jmp done

            
    done:
    ret
readin ENDP














    






print PROC
    lea edx, array              ; Points to the first string
    L1:
    cmp edx, arrayptr           ; Does it point beyond the strings?
    jae done                    ; Yes -> break
    
    call WriteString            ; Doesn't change EDX
    call Crlf                   ; Doesn't change EDX

    scan_for_null:
    inc edx
    cmp BYTE PTR [edx], 0       ; Terminating null?
    jne scan_for_null           ; no -> next character
    inc edx                     ; Pointer to next string

    jmp L1

    done:
    ret
print ENDP



search PROC
    lea edx, array              ; Points to the first string
    L1:
    cmp edx, arrayptr           ; Does it point beyond the strings?
    jae done                    ; Yes -> break

    call WriteString            ; Doesn't change EDX
    call Crlf                   ; Doesn't change EDX

    scan_for_null:
    inc edx
    cmp BYTE PTR [edx], 0       ; Terminating null?
    jne scan_for_null           ; no -> next character
    inc edx                     ; Pointer to next string

    jmp L1

    done:
    ret
search ENDP







main PROC

    ;mov edx, offset fileName
    ;call createoutputfile
    ;mov al , mesToTakeNumber
    ;call Writetofile

    ;cmp [mes1] , 1
    ;jg add1
    ;jl stop



start:
    
    lea edx, mes1
    call WriteString
    call	CrLf
    call ReadDec
    cmp eax, 1
    je add1
    cmp eax, 2
    je print2
    cmp eax, 4
    je search2
    cmp eax, 5
    je stop
    jmp next                    ; This was missing in the OP



add1:
    call readin
    jmp next                    ; Just a better name than in the OP




print2:
    call print
    jmp next                    ; Just a better name than in the OP



search2:
    call search
    jmp next                    ; Just a better name than in the OP



next:                           ; Just a better name than in the OP
    jmp start


stop:
    exit

main ENDP

END main
