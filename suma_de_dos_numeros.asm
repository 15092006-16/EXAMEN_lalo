.model small
.data
    msg1        db 10, 13, 'Ingresa la primer cantidad (preciona enter para terminar): ', '$'
    msg2        db 10, 13, 'Ingresa el segundo numero (preciona enter para terminar): ', '$'
    msg_res     db 10, 13, 'La suma es: ', '$'
    msg_salida  db 10, 13, 10, 13, 'Fin del programa', '$'

    num1        dw 0
    num2        dw 0
    suma        dw 0
    diez        dw 10
.code
main proc
    mov ax, @data
    mov ds, ax

inicio:
    lea dx, msg1
    mov ah, 09h
    int 21h

    xor bx, bx

leer_num1:
    mov ah, 01h
    int 21h

    cmp al, 13
    je guardar_num1

    sub al, '0'
    xor ah, ah
    mov cx, ax

    mov ax, bx
    mul diez
    add ax, cx
    mov bx, ax
    jmp leer_num1

guardar_num1:
    mov num1, bx

    lea dx, msg2
    mov ah, 09h
    int 21h

    xor bx, bx

leer_num2:
    mov ah, 01h
    int 21h

    cmp al, 13
    je guardar_num2

    sub al, '0'
    xor ah, ah
    mov cx, ax

    mov ax, bx
    mul diez
    add ax, cx
    mov bx, ax
    jmp leer_num2

guardar_num2:
    mov num2, bx

    mov ax, num1
    add ax, num2
    mov suma, ax

    lea dx, msg_res
    mov ah, 09h
    int 21h

    mov ax, suma
    xor cx, cx
    mov bx, 10

apilar_digitos:
    xor dx, dx
    div bx
    push dx
    inc cx
    cmp ax, 0
    jne apilar_digitos

imprimir_digitos:
    pop dx
    add dl, '0'
    mov ah, 02h
    int 21h
    loop imprimir_digitos

salir:
    lea dx, msg_salida
    mov ah, 09h
    int 21h

    mov ah, 4Ch
    int 21h
main endp
end main