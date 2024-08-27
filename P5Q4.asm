.MODEL SMALL
.STACK 
.DATA
	COLOR_MENU DB "Green : 'G'", 0DH, 0AH
				DB "Red : 'R'", 0DH, 0AH
				DB "Blue : 'B'", 0DH, 0AH
				DB "Please enter G, B, or R for font's color : $"
	INPUT_COLOR DB ?
	GREEN_MSG DB "You Choose the green color !$"
	RED_MSG DB "You Choose the green color !$"
	BLUE_MSG DB "You Choose the green color !$"
	NEWLINE DB 0DH, 0AH, "$"
.CODE
MAIN PROC
    ; Initialize the data segment
    MOV AX, @DATA
    MOV DS, AX

    ; Display prompt for color choice
    MOV AH, 09H
    LEA DX, COLOR_MENU
    INT 21H

    ; Get user input
    MOV AH, 01H
    INT 21H
    MOV INPUT_COLOR, AL
	
	;--NEWLINE
	MOV AH, 09H
	LEA DX, NEWLINE
	INT 21H

    ; Compare user input and display the corresponding message
    CMP INPUT_COLOR, 'G'
    JE SET_GREEN
    CMP INPUT_COLOR, 'R'
    JE SET_RED
    CMP INPUT_COLOR, 'B'
    JE SET_BLUE


	;SET FONT
	SET_GREEN:
		MOV BL, 02H       ;--SET COLOR
		MOV CX, 27 		  ;--REPEAT 27 CHARACTER
		LEA DX, GREEN_MSG ;--PRINT GREEN MSG
		INT 10H
		JMP DISPLAY       ;--JUMP TO DISPLAY

	SET_RED:
		MOV AH, 04H       ;--SET COLOR
		MOV CX, 25        ;--REPEAT 25 CHARACTER
		LEA DX, RED_MSG ;--PRINT RED MSG
		INT 10H
		JMP DISPLAY       ;--JUMP TO DISPLAY

	SET_BLUE:
		MOV AH, 01H       ;--SET COLOR
		MOV CX, 26        ;--REPEAT 25 CHARACTER
		LEA DX, BLUE_MSG  ;--PRINT BLUE MS
		INT 10H
		JMP DISPLAY       ;--JUMP TO DISPLAY

	DISPLAY:
		MOV AH, 09H
		INT 21H

    ; Exit the program
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN
