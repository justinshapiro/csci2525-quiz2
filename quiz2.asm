; Quiz #2 for CSCI 2525 - Assembly Language & Computer Organization
; Written by Justin Shapiro

TITLE Quiz6.asm
; This program will print a fake decimal point. The user will enter a large decimal number
; as a string.Then the user will provide how many places from the right the decimal point should be

INCLUDE Irvine32.inc

.data

	max = 100

	array BYTE max DUP(0)
	byteCount DWORD ?

	prompt1 BYTE "Please enter a number and hit ENTER when finished: ", 0
	prompt2 BYTE "How many decimal places from the right do you want your decimal point?: ", 0
	prompt3 BYTE "Your number is: ", 0

.code

	main PROC
		
		mov edx, OFFSET prompt1
		call WriteString

		mov edx, OFFSET array
		mov ecx, max + 1
		call ReadString
		mov byteCount, eax

		mov edx, OFFSET prompt2
		call WriteString
		
		call ReadInt
		mov edx, eax

		call Crlf
		call Crlf

		mov ebx, OFFSET array

		call Display
		call Crlf
		call WaitMsg

	exit
	main ENDP


	Display PROC

		push edx
		mov edx, OFFSET prompt3
		call WriteString
		pop edx

		mov esi, ebx
		mov eax, byteCount
		cmp eax, edx
			jg Greater
			jle LessOrEqual
		Greater:
			sub eax, edx
			mov ecx, eax
			L1:
				mov eax, 0
				mov al, [esi]
				sub al, 30h
				call WriteDec
				inc esi
			loop L1

			mov al, "."
			call WriteChar
			jmp noZero

		LessOrEqual:
			mov al, "."
			call WriteChar
			push edx
				sub edx, byteCount
				mov ecx, edx
				LZ:
					mov eax, 0
					call WriteDec
				loop LZ
			pop edx
			mov ecx, byteCount
			jmp L3
			
			noZero:		
				mov ecx, edx
		L3:
			mov eax, 0
			mov al, [esi]
			sub al, 30h
			call WriteDec
			inc esi
		loop L3

	ret
	Display ENDP


END main