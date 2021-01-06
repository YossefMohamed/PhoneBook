include    c:\Irvine\Irvine32.inc
includelib c:\Irvine\irvine32.lib
includelib c:\Irvine\kernel32.lib
includelib y:\masm32\lib\user32.lib


.DATA
       aName BYTE 51 DUP (?)
    arrayptr    DWORD OFFSET array
    array       BYTE 4096 DUP (?)
    mes1        BYTE 10, "1-add number 2-display all numbers 3-remove a number 4-search for a number 5-quit", 0
    check byte 0,0
    ;mes1        BYTE 10, "press 1 to add an element, 2 to print, 3 to quit    ", 0
    yourName  byte "Name :  ",0
    number byte "Number :  ",0
    mesToTakeName byte "Enter Your Name : ",0
    mesToMaxNumber byte "Max Numbers !!!",0
    mesToTakeNumber byte "Enter Your Number : ",0
    msgMoreNumber byte "More Numbers? (y) or (n)",0
    maxNum byte 0,0
    zeros  byte 0,0
    eqaa byte "++",0
    searchInput dword 0,0
    nameSize dd ?
    contacts DWORD 100 DUP(?);array of conects

    index byte ?

    
buffer BYTE 21 DUP(0)          ; input buffer
byteCount DWORD ?              ; holds counter
      



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
    jz zero_name                     ; Yes: don't store a new arrayptr
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
            jz filling                     ; Yes: don't store a new arrayptr
            lea edx, [edx+eax+1]        ; EDX += EAX + 1
            mov arrayptr, edx           ; New pointer, points to the byte where the next string should begin
            lea edx, msgMoreNumber
			call writestring
			call	CrLf
			call readchar
			mov check , al
			cmp check , 79h
			je  take_number
            cmp   maxNum , 3
            jne    filling
            jmp done
 
 filling: 
             mov edx, arrayptr           ; Argument for ReadString: Pointer to memory
            mov ecx, 1                 ; Argument for ReadString: maximal number of 
            mov ecx, 15                 ; Argument for ReadString: maximal number of chars
            mov al , zeros
            mov  [edx], al
            inc     maxNum
            lea edx, [edx+1+1]        ; EDX += EAX + 1
            mov arrayptr, edx           ; New pointer, points to the
             cmp   maxNum , 3
             jne    filling
             jmp done
maxNumFunc:
            lea   edx, mesToMaxNumber
	        call  writeString
	        call	CrLf
	        call	CrLf
            mov    maxNum , 0
            jmp done

zero_name :
        lea edx, [edx-1-1]          ; EDX += EAX + 1
        mov arrayptr, edx           ; New pointer, points to the byte where the next string should 
    

            
    done:
        ret
readin ENDP














    

print_name PROC
    
    done:
    ret
print_name ENDP






print PROC
    lea edx, array              ; Points to the first string
    L1:
    cmp edx, arrayptr           ; Does it point beyond the strings?
    jae done                    ; Yes -> break
    cmp index,0
    je scan_for_null
;    mov ecx,[edx]
 ;   cmp ecx,'+'
  ;  je scan_for_null
    cmp index,1
    je name_print
    jg number_print
    name_print:
    mov eax , edx
    lea edx,yourName
    call writeString
    mov edx,eax
    call WriteString            ; Doesn't change EDX
    call Crlf  
    jmp scan_for_null
    number_print:
     mov eax , edx
    lea edx,number
    call writeString
    mov edx,eax
    call WriteString            ; Doesn't change EDX
    call Crlf                   ; Doesn't change EDX
    scan_for_null:
    inc edx
    cmp BYTE PTR [edx], 0       ; Terminating null?
    jne scan_for_null           ; no -> next character
    inc edx                     ; Pointer to next string
    inc index
    cmp index,5
    je zero_index
    jmp L1
    zero_index:
    mov index,0
    jmp L1

    done:
    ret
print ENDP



search PROC

;code_to_search
 

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
    mov index,0
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