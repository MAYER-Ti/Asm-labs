; Program to read lines from a file, store them in stack, and print them without removing them

.MODEL SMALL
.STACK 100h
.data
    filename DB 'input.txt', 0
    buffer DB 128 DUP(0) ; Temporary buffer for file reading
    stack_pointers DW 64 DUP(0) ; Array to store stack offsets for line beginnings
    sp_index DW 0 ; Current index for stack pointers
    newline DB 13, 10, '$' ; Newline to print between lines
    file_error DB 'Error opening file', 13, 10, '$'

.CODE
START:
    MOV AX, @data
    MOV DS, AX

    ; Open the file
    LEA DX, filename
    MOV AH, 3Dh
    MOV AL, 0 ; Read-only mode
    INT 21h
    JC FILE_ERROR ; Jump if an error occurs
    MOV BX, AX ; File handle

    ; Read file line by line
READ_LINE:
    LEA DX, buffer
    MOV CX, 127 ; Max buffer size - 1
    MOV AH, 3Fh ; Read from file
    INT 21h
    JC FILE_ERROR ; Jump if an error occurs
    CMP AX, 0 ; Check for EOF
    JE PRINT_LINES
    MOV CX, AX ; Store number of bytes read
    MOV BYTE PTR [buffer + CX], 0 ; Add null terminator explicitly

    ; Ensure last line is processed if no carriage return
    MOV DI, CX
    DEC DI
    CMP BYTE PTR [buffer + DI], 0Dh
    JNE ADD_TERMINATOR
    JMP PROCESS_BUFFER

ADD_TERMINATOR:
    MOV BYTE PTR [buffer + CX], 0Dh
    MOV BYTE PTR [buffer + CX + 1], 0
    INC CX
    INC CX

PROCESS_BUFFER:
    XOR SI, SI ; Start of the buffer

    ; Process the buffer
    CMP CX, 0
    JE STORE_LINE
    CMP BYTE PTR [buffer + SI], 0Dh ; Check for carriage return
    JE STORE_LINE
    MOV AL, [buffer + SI] ; Load character into AL
    PUSH AX ; Push character onto stack (use AX for compatibility)
    INC SI
    DEC CX
    JMP PROCESS_BUFFER

STORE_LINE:
    MOV AL, '$'
    PUSH AX ; Push end-of-string marker
    MOV AX, SP ; Store current stack pointer
    MOV DI, sp_index
    MOV [stack_pointers + DI], AX
    ADD sp_index, 2 ; Move to next index
    JMP READ_LINE

PRINT_LINES:
    MOV SI, sp_index
    DEC SI ; Start from the last index
    DEC SI

PRINT_LOOP:
    MOV AX, [stack_pointers + SI]
    MOV BX, AX ; Store stack pointer in BX
    MOV BP, SP ; Backup current SP
PRINT_CHAR:
    MOV SP, BX ; Restore stack pointer
    POP AX ; Get character from stack
    CMP AL, '$'
    JE PRINT_NEWLINE
    MOV DL, AL
    MOV AH, 2
    INT 21h
    JMP PRINT_CHAR

PRINT_NEWLINE:
    MOV SP, BP ; Restore original SP
    LEA DX, newline
    MOV AH, 9
    INT 21h
    SUB SI, 2 ; Move to previous line
    CMP SI, -2
    JGE PRINT_LOOP

    JMP EXIT

FILE_ERROR:
    LEA DX, file_error
    MOV AH, 9
    INT 21h

EXIT:
    MOV AH, 4Ch
    INT 21h

END START
