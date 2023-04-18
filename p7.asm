; Materia: Organización y Arquitrectura De Computadoras
; Nombre: López Mercado Brayan
; Matrícula: 1280838
; Práctica 7
; Fecha: 18 de abril de 2023

%include "pc_io.inc"
section .data ; Datos inicializados (constantes)
NL: db 13, 10
NL_L: equ $-NL
msg: db "Captura Una Cadena: ",10,0
msg1: db "Captura Un Caracter",10,0
ia: db 10,"Inciso A: Hidden In Code",0
ib: db 10,"Inciso B: ",0
ic: db 10,"Inciso C: ",0
id: db 10,"Inciso D: ",0
ie: db 10,"Inciso E: ",0
if: db 10,"Inciso F: ",0
ig: db "Inciso G: ",10,0
ih: db 10,"Inciso H: ",10,0
section .bss ; Datos no inicializados (variables)
cad resb 16

; Inciso A
A resb 512
N resb 32
C resb 8

section .text

global _start:
_start: mov esi, cad

    ;Inciso A
    mov edx,ia
    call puts

    ;Inciso B
    mov edx,ib
    call puts
    mov edx,msg
    call puts
    mov eax, 3
    mov ebx, 0
    mov ecx, A
    mov edx, 512
    mov edx,A
    call puts
    int 0x80

    ;Inciso C
    mov edx,ic
    call puts
    mov edx,msg1
    call puts
    call getche
    mov [C],al
    call salto_linea

    ;Inciso D
    mov edx,id
    call puts
    mov ebx, N
    mov dWord [ebx],0x832FACB2
    mov eax, [ebx]
    call printHex
    call salto_linea

    ;Inciso E
    mov edx,ie
    call puts
    mov ebx,N
    push word[ebx]
    pop dx
    mov cl,dh
    mov ch,dl
    mov eax,ecx
    mov bx,dx
    call printHex
    call salto_linea

    ;Inciso F
    mov edx,if
    call puts
    mov ebx,ecx
    xchg bh,bl
    mov eax,ebx
    call printHex
    call salto_linea
    call salto_linea

    ;Inciso G
    mov edx,ig
    call puts
    pushf
    mov cx,ss
    mov ax,cx
    call printHex
    call salto_linea
    mov cl,ah
    mov ch,al
    mov eax,ecx
    popf
    call printHex
    call salto_linea

    ;Inciso H
    mov edx,ih
    call puts
    lea ax,A
    xlat
    mov dl,al
    call putchar
    call printHex

    ; Kernel Exit Call
    mov eax, 1
    mov ebx,0
    int 0x80

; Subrutina  

printHex:
    pushad
    mov edx, eax
    mov ebx, 0fh
    mov cl, 28
    .nxt: shr eax,cl
    .msk: and eax,ebx
    cmp al, 9
    jbe .menor
    add al,7
    .menor:add al,'0'
    mov byte [esi],al
    inc esi
    mov eax, edx
    cmp cl, 0
    je .print
    sub cl, 4
    cmp cl, 0
    ja .nxt
    je .msk
    .print: mov eax, 4
    mov ebx, 1
    sub esi, 8
    mov ecx, esi
    mov edx, 8
    int 80h
    popad
    ret

salto_linea:
    pushad
    mov eax,4
    mov ebx,1
    mov ecx, NL
    mov edx, NL_L
    int 80h
    popad
    ret
