.model small
.stack 100h

.data
    msg_equal db 'Numbers are equal', 0Dh, 0Ah, '$'
    msg_greater db 'First number is greater', 0Dh, 0Ah, '$'
    msg_less db 'Second number is greater', 0Dh, 0Ah, '$'
.code
; �������, ��� ���������� ������� 286
.286
start:
    ; ������ �������� ������
    mov ax, @data
    mov ds, ax

    ; ������ ���� ����� long long (�� ��� �����)
    push word ptr 1234h ; ������� ����� ������� �����
    push word ptr 5676h ; ������� ����� ������� �����
    push word ptr 1234h ; ������� ����� ������� �����
    push word ptr 5677h ; ������� ����� ������� �����

    ; ����� ������������ ���������
    call CompareLongs
    
    ; �������� ���������� ������ ����� ���������
    je NumbersEqual       ; �����
    jg FirstIsGreater     ; ������
    jl SecondIsGreater    ; ������

NumbersEqual:
    lea dx, msg_equal
    jmp Display
FirstIsGreater:
    lea dx, msg_greater
    jmp Display
SecondIsGreater:
    lea dx, msg_less
Display:
    ; ����� ���������
    mov ah, 09h
    int 21h
    
    ; ���������� ���������
    mov ah, 4Ch
    int 21h

; ==== ������������ ��������� ���� ����� long long ====
; ������ ��������� ������� ����� � �����
CompareLongs proc
    ; �������� ��������� �����
    enter 0, 0
    ; �������� ���� ������:
    ; ��������� �������,
    ; ����� ��������, 
    ; ������� ��������� bp (��������� �� �������� ���� ���������� �������)
    ; ��������� ����������
    ; ��� ������������ ��� ��������� ������
    
    ; ��������� �������� ��������� ����� ��������������
    push ax
    push dx
    push bx
    push cx

    ; ���������� ����� �� �����
    mov ax, [bp+4]       ; ������� ����� ������� �����
    mov dx, [bp+6]       ; ������� ����� ������� �����
    mov bx, [bp+8]       ; ������� ����� ������� �����
    mov cx, [bp+10]      ; ������� ����� ������� �����

    ; ��������� ������� ����
    cmp cx, dx           
    jne CompareEnd        ; ���� �� �����

    ; ��������� ������� ����
    cmp bx, ax
CompareEnd:
    
    ; ������� �������� ��������� ����� �������������
    pop cx
    pop bx
    pop dx
    pop ax
    
    ; ������������ �������� sp = bp
    ; ������������ ���������� �������� bp, ���������� � �������� �����
    leave ; ������� ������� �������� ����              
    ret 8               ; ������� ��������� �� ����� (4 ����� �� 2 �����)
CompareLongs endp       ; ������ �������� ��� ����� (�����), ��������� - ������

end start
