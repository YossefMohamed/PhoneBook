include    c:\Irvine\Irvine32.inc
includelib c:\Irvine\irvine32.lib
includelib c:\Irvine\kernel32.lib
includelib y:\masm32\lib\user32.lib


.data
OpsTitle byte   "1-remove a number 2-add number 3-display all numbers 4-search for a number 5-End",0
OpsNo	byte	?
message byte "hey Bro",0
NumWeAt  dword 0,0
buffer BYTE 21 DUP(0)
byteCount DWORD ? 
input DWORD ?
msgMoreNumber byte "More Numbers? (y) or (n)"
contacts DWORD 100 DUP(?);array of conects
messageName byte  "Please Enter The Name !",0
messageNumber byte "Please Enter the Number !",0
check byte ?



;write==>edx         read==>eax

		.code
		main PROC
	take_operation_to_do:
		;take the operation number
		lea edx,OpsTitle
		call writestring
		call	CrLf
		call readint
		mov OpsNo, al

		
	; Redirection to the  the needed operation
		cmp OpsNo , 1                          
		je remove_number 
		cmp OpsNo , 2                          
		je add_number 
		cmp OpsNo , 3                          
		je display_numbers
		cmp OpsNo , 4                          
		je search_number 
		jmp quit
		

		; "1-remove a number 2-add number 3-display all numbers 4-search for a number"

		remove_number:

			jmp quit
			
			;write==>edx         read==>eax

		add_number:
						
		;take String in array using buffer
;take the name
		lea   edx, messageName
		call  writeString
		call	CrLf
		mov   edx, OFFSET buffer
		mov   ecx, SIZEOF buffer
		call  ReadString
		mov   byteCount, eax
		lea   eax , contacts
		add   eax, NumWeAt
		mov	  eax , offset buffer
;take the number
		take_number:
			lea   edx, messageNumber
			call  writeString
			call	CrLf
			mov   edx, OFFSET buffer
			mov   ecx, SIZEOF buffer
			call  ReadString
			mov   byteCount, eax
			lea   eax , contacts
			add   eax, NumWeAt
			mov	  eax , offset buffer

		;end 
			lea edx, msgMoreNumber
			call writestring
			call	CrLf
			call readchar
			mov check , al
			cmp check , 79h
			je  take_number
			jmp take_operation_to_do
		display_numbers:
			cmp
			jmp quit


	

		search_number:
			lea edx , OpsNo
			call writeString
			call	CrLf
			jmp quit


	quit:
		call	CrLf
		exit	

main ENDP
END main