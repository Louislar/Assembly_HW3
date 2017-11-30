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
	
	
	mov ecx, array1Length					;第一層迴圈，跑array1的長度次數
L1:
	push ecx								;第2層迴圈會用到ecx，所以要push第1層迴圈的ecx值
	push esi
	mov ecx, array2Length
L2:											;第2層迴圈，跑array2的長度次數
	mov edx, [edi]
	cmp edx, [esi]
	jnz L3
	inc count
	
L3:
	ADD esi, 4
	loop L2
	
	pop esi									;array2的index回到起始點
	pop ecx									;第2層迴圈跑完了，把第1層迴圈的ecx pop回來
	ADD edi, 4									;要開始檢查array1的下一項了
	loop L1
	
	mov eax, count
	ret
	CountMatches ENDP
END main