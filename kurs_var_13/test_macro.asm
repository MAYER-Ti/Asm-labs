DOSSEG
.model	small
.stack	100h

; === ����� ������ ===
mWrite macro message
   mov ah, 09h
   lea dx, message
   int 21h
endm

; === ����� ������ � ��������� ������� ===
mWriteln macro message
   mov ah, 09h
   lea dx, message
   int 21h
   lea dx, newline
   int 21h 
endm

mInput macro buf
   lea dx, buf
   mov ah, 0Ah
   int 21h 
endm

; === ���������� ������ ��������� ===
EndProgram macro
   mov ax,4c00h
   int 21h
endm

.data
   ; ���������� ���������
    msg_enter db '������� �������:', 13, 10, '$'
    msg_nom db '���� ', 13, 10, '$'           ; ������������ �����
    msg_gen db '��� ', 13, 10, '$'            ; ����������� �����
    msg_dat db '���� ', 13, 10, '$'           ; ��������� �����
    msg_acc db '���� ', 13, 10, '$'           ; ����������� �����
    msg_inst db '� ', 13, 10, '$'            ; ������������ �����
    msg_prep db '� ', 13, 10, '$'             ; ���������� �����
    newline db 0Dh, 0Ah, '$'

    ; ������� ��� ������
    buffer db 30 dup(0)             ; ������ ��� ����� �������
    output_buffer db 50 dup(0)      ; ������ ��� ������ ��������
.code

start:
   mov ax,@data
   mov ds,ax
   xor ax,ax

   mWriteln msg_enter
   mInput buffer
EndProgram
end	start