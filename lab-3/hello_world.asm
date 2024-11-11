.model small
.stack 100h
.data 
A DW 0,1,2,3,4,5,6,7,8,9
B DW 10 DUP(0)

.code
start:

cld 
lea      si,A
lea      di,B
mov      cx,10 
rep      movsb

end      start