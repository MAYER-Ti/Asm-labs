.model	tiny
.stack	100h
.data
   input_msg db 13,10,'������� �������: ',13,10, '$'
   msg_nom db '???? ', 0           ; ������������
   msg_gen db '??? ', 0            ; �����������
   msg_dat db '???? ', 0           ; ���������
   msg_acc db '???? ', 0           ; �����������
   msg_inst db '? ', 0             ; ������������
   msg_prep db '? ', 0             ; ����������
   newline db 0Dh, 0Ah, '$'        ; ������� ����� ������

   buffer db 50 dup(0)             ; ����� ��� ����� �������
   output_buffer db 50 dup(0)         ; ����� ��� ������ ����������

.code
;.286

mPrintString macro string
   mov dx, offset string
   mov ah, 09h
   int 21h
endm

mInputString macro string
   lea dx, string
   mov ah, 0Ah
   int 21h
endm

start:
   mov ax, @data
   mov ds, ax
   xor ax, ax

   mPrintString input_msg
   ;mInputString buffer
   

   mov ax, 4c00h
   int 21h
end	start