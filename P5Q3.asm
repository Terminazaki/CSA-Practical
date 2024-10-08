.MODEL SMALL
.STACK
.DATA
    PROMPT_ENCRYPTED_WORD DB "Enter encrypted word: $"
    PROMPT_DECRYPT_KEY DB 0DH, 0AH, "Enter decryption key (1-9): $"
    SECRET_WORD_MSG DB 0DH, 0AH, "The secret word is: $"
    PARA_LIST LABEL BYTE
    MAX_LEN DB 20
    ACT_LEN DB ?
    INPUT_DATA DB 20 DUP ("$")
    INPUT_KEY DB ?

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ;-- DISPLAY PROMPT FOR ENCRYPTED WORD
    MOV AH, 09H
    LEA DX, PROMPT_ENCRYPTED_WORD
    INT 21H

    ;-- GET USER INPUT (STRING)
    MOV AH, 0AH
    LEA DX, PARA_LIST
    INT 21H

    ;-- DISPLAY PROMPT FOR DECRYPTION KEY
    MOV AH, 09H
    LEA DX, PROMPT_DECRYPT_KEY
    INT 21H

    ;-- GET USER INPUT (CHAR)
    MOV AH, 01H
    INT 21H
    MOV INPUT_KEY, AL
    SUB INPUT_KEY, 30H

    ;-- DISPLAY SECRET WORD
    MOV AH, 09H
    LEA DX, SECRET_WORD_MSG
    INT 21H
    MOV CL, ACT_LEN
    MOV SI, 0

	DECRYPTION:
		MOV AL, INPUT_DATA[SI]
		SUB AL, INPUT_KEY      ; Decrypt the character by subtracting the key
		MOV AH, 02H
		MOV DL, AL
		INT 21H
		INC SI
    LOOP DECRYPTION

    ;-- EXIT PROGRAM
    MOV AX, 4C00H
    INT 21H

MAIN ENDP
END MAIN
