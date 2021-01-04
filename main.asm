include    c:\Irvine\Irvine32.inc
includelib c:\Irvine\irvine32.lib
includelib c:\Irvine\kernel32.lib
includelib y:\masm32\lib\user32.lib
.data
OpsTitle byte   "1-remove a number 2-add number 3-display all numbers 4-search for a number"
OpsNo	byte	?
message byte "hey Bro"
NumWeAt  dword 0
buffer BYTE 21 DUP(0)
byteCount DWORD ? 
input DWORD ?
contects DWORD 100 DUP(?);array of conects
messageName byte  "Please Enter The Name !"
messageNumber byte "Please Enter the Name !"
check byte ?



;write==>edx         read==>eax

		.code
		main PROC
		;take the operation number
		lea edx,OpsTitle
		call writestring
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
		mov   edx,0
		lea   edx, messageName
		call  writeString
		mov   edx, OFFSET buffer
		mov   ecx, SIZEOF buffer
		call  ReadString
		mov   byteCount, eax
		lea   eax , contects
		add   eax, NumWeAt
		mov	  eax , offset buffer

		;end 

			jmp quit
		display_numbers:
			lea edx , message
			call writestring
			jmp quit

		search_number:
			lea edx , OpsNo
			call writeString
			jmp quit


	quit:
		call	CrLf
		exit	

main ENDP
END main