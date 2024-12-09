.model small 
.stack 100h

include macroses.asm

.data

    test_msg db 'abcd','$'

.code


start:
    mov ax, @data
    mov ds, ax
    mov es, ax
    
    mWriteln test_msg
    
    mEndProgram
END start
