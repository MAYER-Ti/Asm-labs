     ; === Макросы ===
PrintString macro message
   mov ah, 09h
   lea dx, message
   int 21h
endm