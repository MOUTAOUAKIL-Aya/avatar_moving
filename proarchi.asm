data segment

data ends
spile segment para stack
db 1024 dup(?)
spile ends
assume ds:data,cs:code,ss:spile
code segment
initgraph proc
mov ax,0013h
int 10h
ret
initgraph endp
drawbody proc
mov dx,75
mov cx,150
mov al,7
bc:
cmp dx,126
jg fn
mov ah,0Ch
int 10h
inc dx
jmp bc
fn:
ret
drawbody endp
drawlegs proc
mov dx,130
mov cx,148
mov al,7
mov si,1
bc2:
cmp si,2
jg fn2
bc1:
cmp dx,180
jg fn1
mov ah,0Ch
int 10h
inc dx
jmp bc1
fn1:
inc si
mov cx,152
mov dx,130
jmp bc2
fn2:
mov cx,149
mov si,1
bc4:
cmp si,2
jg fn4
mov dx,126
bc3:
cmp dx,130
jg fn3
mov ah,0Ch
int 10h
inc dx
jmp bc3
fn3:
mov cx,151
inc si
jmp bc4
fn4:
ret
drawlegs endp
drawarm proc
mov al,7
mov dx,80
mov cx,125
bc5:
cmp cx,152
jg fn5
mov ah,0Ch
int 10h
inc cx
jmp bc5
fn5:
inc dx
mov ah,0Ch
int 10h
inc dx
mov ah,0Ch
int 10h
inc cx
bc6:
cmp dx,120
jg fn6
mov ah,0Ch
int 10h
inc dx
jmp bc6
fn6:

ret 
drawarm endp
drawhead proc
mov al,7
mov si,1
mov dx,74
mov cx,136
bc7:
cmp cx,164
jg fn7
mov ah,0Ch
int 10h
inc cx
jmp bc7
fn7:
mov cx,136
mov dx,46
inc si
cmp si,2
jg fin
jmp bc7
fin:
mov si,1
mov dx,47
mov cx,135
bc8:
cmp dx,73
jg fn8
mov ah,0Ch
int 10h
inc dx
jmp bc8
fn8:
mov cx,165
mov dx,47
inc si
cmp si,2
jg fin1
jmp bc8
fin1:
ret
drawhead endp
drawman proc
call drawbody
call drawlegs
call drawarm
call drawhead
ret 
drawman endp
state1 proc
mov al,7
mov dx,80
mov cx,125
bouc:
cmp dx,65
jl fin2
mov ah,0Ch
int 10h
dec dx
jmp bouc
fin2:
ret
state1 endp
state2 proc
mov al,7
mov dx,80
mov cx,125
mov si,1
bouc1:
cmp dx,68
jl fin3
cmp si,3
jg bouc2
mov ah,0Ch
int 10h
dec dx
inc si
jmp bouc1
bouc2:
dec cx
mov si,1
jmp bouc1
fin3:
ret 
state2 endp
state3 proc
mov dx,80
mov cx,125
mov al,7
mov si,1
bouc4:
cmp dx,68
jl fin4
cmp si,3
jg bouc3
mov ah,0Ch
int 10h
dec dx
inc si
jmp bouc4
bouc3:
inc cx
mov si,1
jmp bouc4
fin4:
ret 
state3 endp
delay PROC
    push ax
    push bx
    push cx
    push dx

    mov ah, 86h    
    mov cx, 0        
    mov dx, 65535
    int 15h

    pop dx
    pop cx
    pop bx
    pop ax
    ret
delay ENDP
wave proc
mov si,1
call drawman
boucle:
cmp si,1
je st1
cmp si,2
je st2
cmp si,3
je st3
cmp si,4
je st4
st1:
call state1
call delay
call delay
call delay
call delay
call cls
inc si
jmp boucle
st2:
call state2
call delay
call delay
call delay
call delay
call cls
inc si
jmp boucle
st3:
call state1
call delay
call delay
call delay
call delay
call cls
inc si
jmp boucle
st4:
call state3
call delay
call delay
call delay
call delay
call cls
mov si,1
jmp boucle
ret
wave endp
cls proc
mov dx,65
mov cx,120
mov al,0
boucle1:
cmp cx,130
jg finito
boucle2:
cmp dx,79
jg fini
mov ah,0Ch
int 10h
inc dx
jmp boucle2
fini:
mov dx,0
inc cx
jmp boucle1
finito:
ret
cls endp
main:
      call initgraph
      call wave
code ends
end main