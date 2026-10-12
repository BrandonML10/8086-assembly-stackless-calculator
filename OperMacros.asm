.MODEL SMALL
.STACK 

.DATA
; ----- Mensajes para entrada validada -----
mensaje1      db 10,13,'Ingrese el primer numero (1-3 digitos): $'
mensaje2      db 10,13,'Ingrese el segundo numero (1-3 digitos): $'
mensajeError  db 10,13,'Entrada invalida. Solo se permiten digitos (0-9). $'
mensajeFin    db 10,13,'Se han capturado ambos numeros. Fin del programa.$'

; ----- Variables para el primer número (entrada validada) -----
centenas1     db ?
decenas1      db ?
unidades1     db ?

; ----- Variables para el segundo número (entrada validada) -----
centenas2     db ?
decenas2      db ?
unidades2     db ?

; ----- Variables para la OPERACION SUMA -----
sum_mil       db ?
sum_cen       db ?
sum_dec       db ?
sum_uni       db ?
aux           db ?
mensajeResul  db 10,13,"El resultado es: $"

; ----- Variables para la OPERACION RESTA -----
resta_resultado db 3 dup(?)
mensajeResulResta db 10,13,"El resultado de la resta es: $"

; ----- Variables para la OPERACION MULTIPLICACION -----
mul_unidad1   db ?  
mul_decena1   db ?  
mul_centana1  db ?
mul_unidad2   db ?  
mul_decena2   db ?
mul_centana2  db ?
registro      db ?
cero          db ?
uno           db ?
dos           db ?
tres          db ?
cuatro        db ?
cinco         db ?
seis          db ?
siete         db ?
ocho          db ?
nueve         db ?
diez          db ?
once          db ?
mul_aux       db ?
mensajeResulMul db 10,13,"El resultado de la multiplicacion es: $"

; ----- Variables para la OPERACION DIVISION -----
dividend      dw ?
divisor       dw ?
quotient      dw ?
remainder     dw ?
qHundred      db ?
qTen          db ?
qOne          db ?
rHundred      db ?
rTen          db ?
rOne          db ?
temp          dw ?
mensajeResulDiv db 10,13,"El resultado de la division es: $"
mensajeErrorDiv db 10,13,"Error: Division por cero.$"

; ----- Menu -----
menuMsg       db 10,13,'Seleccione operacion:',10,13, \
                    '1. Suma',10,13,                \
                    '2. Resta',10,13,               \
                    '3. Multiplicacion',10,13,      \
                    '4. Division',10,13,            \
                    '5. Salir',10,13,               \
                    'Opcion: $'
opcion        db ?

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

menu:
    MOV AH,09h
    LEA DX, menuMsg
    INT 21h
    MOV AH,01h
    INT 21h
    MOV opcion, AL
    CMP AL, '5'
    JE salir
    ; Se lee el primer número (entrada validada)
    MOV AH,09h
    LEA DX, mensaje1
    INT 21h
    MOV centenas1, 0
    MOV decenas1, 0
    MOV unidades1, 0
primerDigito1:
    MOV AH,01h
    INT 21h
    CMP AL,13
    JE errorNum1
    CMP AL,'0'
    JB errorNum1
    CMP AL,'9'
    JA errorNum1
    SUB AL,30h
    MOV unidades1, AL
segundoDigito1:
    MOV AH,01h
    INT 21h
    CMP AL,13
    JE unDigito1
    CMP AL,'0'
    JB errorNum1
    CMP AL,'9'
    JA errorNum1
    MOV AH, unidades1
    MOV decenas1, AH
    SUB AL,30h
    MOV unidades1, AL
tercerDigito1:
    MOV AH,01h
    INT 21h
    CMP AL,13
    JE dosDigitos1
    CMP AL,'0'
    JB errorNum1
    CMP AL,'9'
    JA errorNum1
    MOV AH, decenas1
    MOV centenas1, AH
    MOV AH, unidades1
    MOV decenas1, AH
    SUB AL,30h
    MOV unidades1, AL
    JMP finPrimerNumero
unDigito1:
    MOV decenas1, 0
    MOV centenas1, 0
    JMP finPrimerNumero
dosDigitos1:
    MOV centenas1, 0
finPrimerNumero:
    ; Se lee el segundo número (entrada validada)
    MOV AH,09h
    LEA DX, mensaje2
    INT 21h
    MOV centenas2, 0
    MOV decenas2, 0
    MOV unidades2, 0
primerDigito2:
    MOV AH,01h
    INT 21h
    CMP AL,13
    JE errorNum2
    CMP AL,'0'
    JB errorNum2
    CMP AL,'9'
    JA errorNum2
    SUB AL,30h
    MOV unidades2, AL
segundoDigito2:
    MOV AH,01h
    INT 21h
    CMP AL,13
    JE unDigito2
    CMP AL,'0'
    JB errorNum2
    CMP AL,'9'
    JA errorNum2
    MOV AH, unidades2
    MOV decenas2, AH
    SUB AL,30h
    MOV unidades2, AL
tercerDigito2:
    MOV AH,01h
    INT 21h
    CMP AL,13
    JE dosDigitos2
    CMP AL,'0'
    JB errorNum2
    CMP AL,'9'
    JA errorNum2
    MOV AH, decenas2
    MOV centenas2, AH
    MOV AH, unidades2
    MOV decenas2, AH
    SUB AL,30h
    MOV unidades2, AL
    JMP finSegundoNumero
unDigito2:
    MOV decenas2, 0
    MOV centenas2, 0
    JMP finSegundoNumero
dosDigitos2:
    MOV centenas2, 0
finSegundoNumero:
    ; Se procede según la opcion seleccionada
    CMP opcion, '1'
    JE opSuma
    CMP opcion, '2'
    JE opResta
    CMP opcion, '3'
    JE opMult
    CMP opcion, '4'
    JE opDiv
    JMP menu

; ---------------------- Operacion: SUMA ----------------------
opSuma:
    MOV AL, unidades1
    ADD AL, unidades2
    CMP AL, 10
    JB suma_no_c_unidad
       SUB AL, 10
       MOV aux, 1
       JMP suma_hecho_unidad
suma_no_c_unidad:
    MOV aux, 0
suma_hecho_unidad:
    MOV sum_uni, AL

    MOV AL, decenas1
    ADD AL, decenas2
    ADD AL, aux
    CMP AL, 10
    JB suma_no_c_decena
       SUB AL, 10
       MOV aux, 1
       JMP suma_hecho_decena
suma_no_c_decena:
    MOV aux, 0
suma_hecho_decena:
    MOV sum_dec, AL

    MOV AL, centenas1
    ADD AL, centenas2
    ADD AL, aux
    CMP AL, 10
    JB suma_no_c_centena
       SUB AL, 10
       MOV aux, 1
       JMP suma_hecho_centena
suma_no_c_centena:
    MOV aux, 0
suma_hecho_centena:
    MOV sum_cen, AL
    MOV AL, aux
    MOV sum_mil, AL

    MOV AH,09h
    LEA DX, mensajeResul
    INT 21h

    ; Eliminacion de ceros a la izquierda en la suma:
    CMP sum_mil, 0
    JNE print_sum_mil
    CMP sum_cen, 0
    JNE print_sum_cen
    CMP sum_dec, 0
    JNE print_sum_dec
    ; Si sum_mil, sum_cen y sum_dec son 0, imprime sum_uni:
    MOV AL, sum_uni
    ADD AL, 30h
    MOV DL, AL
    MOV AH,02h
    INT 21h
    JMP volver_menu

print_sum_mil:
    MOV AL, sum_mil
    ADD AL, 30h
    MOV DL, AL
    MOV AH,02h
    INT 21h
    ; Imprime el resto sin comprobacion:
    MOV AL, sum_cen
    ADD AL, 30h
    MOV DL, AL
    MOV AH,02h
    INT 21h
    MOV AL, sum_dec
    ADD AL, 30h
    MOV DL, AL
    MOV AH,02h
    INT 21h
    MOV AL, sum_uni
    ADD AL, 30h
    MOV DL, AL
    MOV AH,02h
    INT 21h
    JMP volver_menu

print_sum_cen:
    MOV AL, sum_cen
    ADD AL, 30h
    MOV DL, AL
    MOV AH,02h
    INT 21h
    MOV AL, sum_dec
    ADD AL, 30h
    MOV DL, AL
    MOV AH,02h
    INT 21h
    MOV AL, sum_uni
    ADD AL, 30h
    MOV DL, AL
    MOV AH,02h
    INT 21h
    JMP volver_menu

print_sum_dec:
    MOV AL, sum_dec
    ADD AL, 30h
    MOV DL, AL
    MOV AH,02h
    INT 21h
    MOV AL, sum_uni
    ADD AL, 30h
    MOV DL, AL
    MOV AH,02h
    INT 21h
    JMP volver_menu

; ---------------------- Operacion: RESTA ----------------------
opResta:
    MOV AL, unidades1
    SUB AL, unidades2
    JNC resta_no_borrow_u
       ADD AL, 10
       DEC decenas1
resta_no_borrow_u:
    MOV resta_resultado+2, AL

    MOV AL, decenas1
    SUB AL, decenas2
    JNC resta_no_borrow_d
       ADD AL, 10
       DEC centenas1
resta_no_borrow_d:
    MOV resta_resultado+1, AL

    MOV AL, centenas1
    SUB AL, centenas2
    MOV resta_resultado, AL

    MOV AH,09h
    LEA DX, mensajeResulResta
    INT 21h
    MOV AL, resta_resultado
    CMP AL, 0
    JE resta_check_decenas
       MOV AH,02h
       MOV DL, resta_resultado
       ADD DL, 30h
       INT 21h
resta_check_decenas:
    MOV AL, resta_resultado
    CMP AL, 0
    JNE resta_print_decenas
       MOV AL, resta_resultado+1
       CMP AL, 0
       JE resta_skip_decenas
resta_print_decenas:
    MOV AH,02h
    MOV DL, resta_resultado+1
    ADD DL, 30h
    INT 21h
resta_skip_decenas:
    MOV AH,02h
    MOV DL, resta_resultado+2
    ADD DL, 30h
    INT 21h
    JMP volver_menu

; ---------------------- Operacion: MULTIPLICACION ----------------------
opMult:
    ; Copiar la entrada validada a las variables de multiplicacion
    MOV AL, centenas1
    MOV mul_centana1, AL
    MOV AL, decenas1
    MOV mul_decena1, AL
    MOV AL, unidades1
    MOV mul_unidad1, AL
    MOV AL, centenas2
    MOV mul_centana2, AL
    MOV AL, decenas2
    MOV mul_decena2, AL
    MOV AL, unidades2
    MOV mul_unidad2, AL

    MOV AL, mul_unidad1
    MOV BL, mul_unidad2
    MUL BL
    MOV registro, AL
    MOV AL, registro
    AAM
    MOV cero, AL
    MOV mul_aux, AH

    MOV AL, mul_decena1
    MOV BL, mul_unidad2
    MUL BL
    ADD AL, mul_aux
    MOV registro, AL
    MOV AL, registro
    AAM
    MOV uno, AL
    MOV mul_aux, AH

    MOV AL, mul_centana1
    MOV BL, mul_unidad2
    MUL BL
    ADD AL, mul_aux
    MOV registro, AL
    MOV AL, registro
    AAM
    MOV dos, AL
    MOV tres, AH

    MOV AL, mul_unidad1
    MOV BL, mul_decena2
    MUL BL
    MOV registro, AL
    AAM
    MOV cuatro, AL
    MOV mul_aux, AH

    MOV AL, mul_decena1
    MOV BL, mul_decena2
    MUL BL
    ADD AL, mul_aux
    MOV registro, AL
    MOV AL, registro
    AAM
    MOV cinco, AL
    MOV mul_aux, AH

    MOV AL, mul_centana1
    MOV BL, mul_decena2
    MUL BL
    ADD AL, mul_aux
    MOV registro, AL
    MOV AL, registro
    AAM
    MOV seis, AL
    MOV siete, AH

    MOV AL, mul_unidad1
    MOV BL, mul_centana2
    MUL BL
    MOV registro, AL
    AAM
    MOV ocho, AL
    MOV mul_aux, AH

    MOV AL, mul_decena1
    MOV BL, mul_centana2
    MUL BL
    ADD AL, mul_aux
    MOV registro, AL
    MOV AL, registro
    AAM
    MOV nueve, AL
    MOV mul_aux, AH

    MOV AL, mul_centana1
    MOV BL, mul_centana2
    MUL BL
    ADD AL, mul_aux
    MOV registro, AL
    MOV AL, registro
    AAM
    MOV diez, AL
    MOV once, AH

    MOV AL, uno
    ADD AL, cuatro
    AAM
    MOV uno, AL
    MOV mul_aux, AH
    MOV AL, dos
    ADD AL, cinco
    ADD AL, ocho
    ADD AL, mul_aux
    AAM
    MOV dos, AL
    MOV mul_aux, AH
    MOV AL, tres
    ADD AL, seis
    ADD AL, nueve
    ADD AL, mul_aux
    AAM
    MOV tres, AL
    MOV mul_aux, AH
    MOV AL, siete
    ADD AL, diez
    ADD AL, mul_aux
    AAM
    MOV siete, AL
    MOV mul_aux, AH
    MOV AL, once
    ADD AL, mul_aux
    MOV once, AL

    MOV AH,09h
    LEA DX, mensajeResulMul
    INT 21h

    ; Eliminacion de ceros a la izquierda en la multiplicacion:
    CMP once, 0
    JNE print_mul_once
    CMP siete, 0
    JNE print_mul_siete
    CMP tres, 0
    JNE print_mul_tres
    CMP dos, 0
    JNE print_mul_dos
    CMP uno, 0
    JNE print_mul_uno
    ; Si once, siete, tres, dos y uno son 0, imprime el digito de las unidades (cero):
    MOV AL, cero
    ADD AL,30h
    MOV DL, AL
    MOV AH,02h
    INT 21h
    JMP volver_menu

print_mul_once:
    MOV AL, once
    ADD AL,30h
    MOV DL, AL
    MOV AH,02h
    INT 21h
    ; Imprime el resto sin comprobacion:
    MOV AL, siete
    ADD AL,30h
    MOV DL, AL
    MOV AH,02h
    INT 21h
    MOV AL, tres
    ADD AL,30h
    MOV DL, AL
    MOV AH,02h
    INT 21h
    MOV AL, dos
    ADD AL,30h
    MOV DL, AL
    MOV AH,02h
    INT 21h
    MOV AL, uno
    ADD AL,30h
    MOV DL, AL
    MOV AH,02h
    INT 21h
    MOV AL, cero
    ADD AL,30h
    MOV DL, AL
    MOV AH,02h
    INT 21h
    JMP volver_menu

print_mul_siete:
    MOV AL, siete
    ADD AL,30h
    MOV DL, AL
    MOV AH,02h
    INT 21h
    MOV AL, tres
    ADD AL,30h
    MOV DL, AL
    MOV AH,02h
    INT 21h
    MOV AL, dos
    ADD AL,30h
    MOV DL, AL
    MOV AH,02h
    INT 21h
    MOV AL, uno
    ADD AL,30h
    MOV DL, AL
    MOV AH,02h
    INT 21h
    MOV AL, cero
    ADD AL,30h
    MOV DL, AL
    MOV AH,02h
    INT 21h
    JMP volver_menu

print_mul_tres:
    MOV AL, tres
    ADD AL,30h
    MOV DL, AL
    MOV AH,02h
    INT 21h
    MOV AL, dos
    ADD AL,30h
    MOV DL, AL
    MOV AH,02h
    INT 21h
    MOV AL, uno
    ADD AL,30h
    MOV DL, AL
    MOV AH,02h
    INT 21h
    MOV AL, cero
    ADD AL,30h
    MOV DL, AL
    MOV AH,02h
    INT 21h
    JMP volver_menu

print_mul_dos:
    MOV AL, dos
    ADD AL,30h
    MOV DL, AL
    MOV AH,02h
    INT 21h
    MOV AL, uno
    ADD AL,30h
    MOV DL, AL
    MOV AH,02h
    INT 21h
    MOV AL, cero
    ADD AL,30h
    MOV DL, AL
    MOV AH,02h
    INT 21h
    JMP volver_menu

print_mul_uno:
    MOV AL, uno
    ADD AL,30h
    MOV DL, AL
    MOV AH,02h
    INT 21h
    MOV AL, cero
    ADD AL,30h
    MOV DL, AL
    MOV AH,02h
    INT 21h
    JMP volver_menu

; ---------------------- Operacion: DIVISION ----------------------
opDiv:
    MOV AL, centenas1
    MOV AH, 0
    MOV BX, 100
    MUL BX
    MOV temp, AX
    MOV AL, decenas1
    MOV AH, 0
    MOV BX, 10
    MUL BX
    ADD AX, temp
    MOV temp, AX
    MOV AL, unidades1
    MOV AH, 0
    ADD AX, temp
    MOV dividend, AX

    MOV AL, centenas2
    MOV AH, 0
    MOV BX, 100
    MUL BX
    MOV temp, AX
    MOV AL, decenas2
    MOV AH, 0
    MOV BX, 10
    MUL BX
    ADD AX, temp
    MOV temp, AX
    MOV AL, unidades2
    MOV AH, 0
    ADD AX, temp
    MOV divisor, AX

    MOV AX, divisor
    CMP AX, 0
    JNE div_ok
       MOV AH,09h
       LEA DX, mensajeErrorDiv
       INT 21h
       JMP volver_menu
div_ok:
    MOV AX, dividend
    XOR DX, DX
    MOV BX, divisor
    DIV BX
    MOV quotient, AX
    MOV remainder, DX

    MOV AX, quotient
    XOR DX, DX
    MOV BX, 100
    DIV BX
    MOV qHundred, AL
    MOV AX, DX
    XOR DX, DX
    MOV BX, 10
    DIV BX
    MOV qTen, AL
    MOV qOne, DL

    MOV AH,09h
    LEA DX, mensajeResulDiv
    INT 21h
    CMP qHundred, 0
    JNE div_print_hundreds
    CMP qTen, 0
    JNE div_print_tens
div_print_single:
    MOV AH,02h
    MOV DL, qOne
    ADD DL,30h
    INT 21h
    JMP volver_menu
div_print_tens:
    MOV AH,02h
    MOV DL, qTen
    ADD DL,30h
    INT 21h
    MOV DL, qOne
    ADD DL,30h
    INT 21h
    JMP volver_menu
div_print_hundreds:
    MOV AH,02h
    MOV DL, qHundred
    ADD DL,30h
    INT 21h
    MOV DL, qTen
    ADD DL,30h
    INT 21h
    MOV DL, qOne
    ADD DL,30h
    INT 21h

volver_menu:
    JMP menu

errorNum1:
    MOV AH,09h
    LEA DX, mensajeError
    INT 21h
    JMP primerDigito1

errorNum2:
    MOV AH,09h
    LEA DX, mensajeError
    INT 21h
    JMP primerDigito2

salir:
    MOV AH,4Ch
    INT 21h
MAIN ENDP
END MAIN
