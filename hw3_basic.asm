TITLE Example of ASM                (asmExample.ASM)

; This program locates the cursor and displays the
; system time. It uses two Win32 API structures.
; Last update: 6/30/2005

INCLUDE Irvine32.inc

; Redefine external symbols for convenience
; Redifinition is necessary for using stdcall in .model directive 
; using "start" is because for linking to WinDbg.  added by Huang
 
main          EQU start@0

	CountMatches PROTO
		

.data
	array1 sdword 10, 5, 4, -6, 2, 11, 12
	array2 sdword 10, 5, 3, 1, 4, 2, -6
	array1Length sdword ?
	array2Length sdword ?
	count sdword 0

.code
main PROC
	INVOKE CountMatches
	call WriteDec
	call Crlf
	call WaitMsg
	exit
main ENDP



	CountMatches PROC
	mov array1Length, LENGTHOF array1
	mov array2Length, LENGTHOF array2
	mov edi, OFFSET array1
	mov esi, OFFSET array2
	
	
	mov ecx, array1Length					;迴圈，跑array1的長度次數
L1:
	mov edx, [edi]
	cmp edx, [esi]
	jnz L3
	inc count
	
L3:
	ADD esi, 4								;兩個array的下一項
	ADD edi, 4									
	loop L1
	
	mov eax, count
	ret
	CountMatches ENDP
END main