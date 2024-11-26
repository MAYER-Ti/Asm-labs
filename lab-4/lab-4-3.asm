.model	small
.stack	100h
.data
     array DB 10 DUP(5 DUP('0')) 
     newline DB 0Dh, 0Ah, '$'
     ;; ������� 10 �����, 5 ��������     
custom_segment SEGMENT
     seg_array DB 10 DUP(5 DUP ('2'))
custom_segment ENDS
     
.code
start:
      mov ax, @data
      mov ds, ax
      
      mov ax, custom_segment
      mov es, ax
      mov ax, 0    

      call incEvenRow
      
      call printMatrix
       
      ; ���������� ������ ���������
      mov ax, 4c00h
      int 21h

      
incEvenRow:
      lea bx, es:seg_array
      mov si, 0

column_loop:   
      ; ��� �������� �� ������� ��������� bx �� 5 ���������,
      ; ��� �������� �� �������� ��������� si �� 1
      
row_loop:
      
      add [bx][si], 1
      inc si
      cmp si, 5      
      jne row_loop


      add bx, 10 ; ��� ������ �� 5
      cmp bx, offset es:seg_array + 50
      mov si, 0
      jne column_loop
      
      
      ret
    
printMatrix:
          
   ; ????? ??????? ?? ?????
    lea si, es:seg_array           ; ????????? ?? ?????? ???????
    mov cx, 10              ; ?????????? ?????
print_matrix_loop:
    push cx                 ; ????????? ??????? ?????
    mov cx, 5               ; ?????????? ????????? ? ??????

print_row:
    mov al, [si]            ; ????????? ???????
    mov ah, 0Eh             ; ??????? BIOS: ????? ???????
    int 10h                 ; ????? ???????
    inc si                  ; ????????? ? ?????????? ????????
    loop print_row          ; ????????? ??? ???? ????????? ??????

    ; ?????? ????? ??????
    mov ah, 09h             ; ??????? DOS: ????? ??????
    lea dx, newline         ; ????????? ?? ?????? ????? ??????
    int 21h

    pop cx                  ; ??????????????? ??????? ?????
    loop print_matrix_loop       ; ????????? ? ????????? ??????

    ret
      


      end start    
      
      
        