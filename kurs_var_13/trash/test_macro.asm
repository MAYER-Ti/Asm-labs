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
    msg_enter db '������� �������:', '$'
    msg_nom db '���� ', '$'           ; ������������ �����
    msg_gen db '��� ', '$'            ; ����������� �����
    msg_dat db '���� ', '$'           ; ��������� �����
    msg_acc db '���� ', '$'           ; ����������� �����
    msg_inst db '� ', '$'            ; ������������ �����
    msg_prep db '� ', '$'             ; ���������� �����
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
   
EndProgram
end	start