;-----------------------------------------------------------------------
;	Projet D'Assembleur
;	MOHAMED AZELMAD
;-----------------------------------------------------------------------
; "Programme Calculatrice"
;-----------------------------------------------------------------------
data segment     
    _ligne      DB  '########################################',9,9,9,9,9,'$'
    _main_menu	DB	9,9,9,' 1: Decimal',9,' 2: Hexadecimal ',10,9,9,9,9,9,9,' Taper le type de votre operation: $',10
    _title_Dev	DB	'DEV : MOHAMED AZELMAD ',10,9,9,9,9,9,'$'
    _title_1_D	DB	9,9,9,9,9,9,'Calculatrice format decimal' ,10,9,9,9,9,9,'$' 
    _title_1_H	DB	9,9,9,9,9,9,'Calculatrice format hexadecimal' ,10,9,9,9,9,9,'$'
	_qn1D		DB  9,9,9,'   n1 = $'
	_qn2D		DB  '   n2 = $'
	_n1D		DB  ?
	_n2D		DB  ? 
	_x		    DB  ?
	_menu_D		DB	9,9,9,9,9,9,9,9,' 1:(+) 2:(-) 3:(x) 4:(/)',10,9,9,9,9,9,9,' Entrez le numero de votre operation: $'
	_r_addD		DB  9,9,9,9,9,9,'   n1 + n2 = $'
	_r_subD		DB  9,9,9,9,9,9,'   n1 - n2 = $'
	_r_mulD		DB  9,9,9,9,9,9,'   n1 x n2 = $'
	_r_divD		DB  9,9,9,9,9,9,'   n1 / n2 = $'
	_q_dz		DB	'Erreur : Division par zero',9,9,9,9,9,'$'
	_q_st		DB	'Erreur : Soustarction donne une nombre negative',9,9,9,'$'
	_quit_D		DB	10,9,9,9,9,9,9,9,9,9,9,'  > Quitter (o/n)?   $'
    _returnligne DB '  ',10,9,9,9,9,9,9,'  $'
ends
code segment
start:
; set segment registers:
    mov ax, data
    mov ds, ax
    mov es, ax
    mov ax,0
    mov dx,0
    mov bx,0 
    ;AFICHAGE DE NOM DE DEV 
    mov ah,09h
    mov dl,offset _ligne 
    int 21h 
    ;AFICHAGE DE NOM DE DEV 
    mov ah,09h
    mov dl,offset _title_Dev 
    int 21h 
    ;SAISIE DE TYPE DE CALCULATRICE 
    mov ah,09h
    mov dl,offset _main_menu 
    int 21h    
    ;SAISIE DE TYPE DE CALCULATRICE 
    mov ah,01h
    mov al,0
    int 21h 
    sub al,48    
    cmp al,1 
    jne HEXADECIMAL 
    je DECIMAL
    er_division:
    mov ah,09h 
    mov dx,0
    mov dx,offset _q_dz 
    int 21h
    jmp endoper 
    er_soustraction:
    mov ah,09h 
    mov dx,0
    mov dx,offset _q_st 
    int 21h
    jmp endoper
    DECIMAL:
    ;AFICHAGE DE TYPE DE CALCULATRICE 
    mov ah,09h
    mov dl,offset _title_1_D 
    int 21h
    ;AFICHAGE DE SAISIE DE NOMBRE 1 
    mov ah,09h
    mov dl,offset _qn1D 
    int 21h
    ;SAISIE DE NOMBRE 1 
    mov ah,01h
    int 21h
    sub al,48
    mov _n1D,al 
    ;AFICHAGE DE SAISIE DE NOMBRE 2 
    mov ah,09h
    mov dl,offset _qn2D 
    int 21h
    ;SAISIE DE NOMBRE 2 
    mov al,0
    mov ah,01h 
    int 21h 
    sub al,48
    mov _n2D,al 
    ;AFICHAGE DE MENU
    mov ah,09h
    mov dx,offset _menu_D 
    int 21h
    ;SAISIE DE CHOIX DE MENU 
    mov al,0
    mov ah,01h 
    int 21h 
    sub al,48
    cmp al,1
    je PROG_ADDITION_D
    cmp al,2
    je PROG_SOUSTRACTION_D
    cmp al,3
    je PROG_MULTIPLICATION_D
    PROG_DIVISION_D:
    mov ah,09h
    mov dx,offset _r_divD 
    int 21h
    mov ax,0
    mov dx,0
    mov bx,0
    mov al,_n1D
    mov bl,_n2D
    cmp bl,0
    je er_division
    div bl
    add al,48
    mov dl,al
    mov ah,02h
    int 21h
    jmp endoper
    PROG_ADDITION_D:
    mov ah,09h
    mov dx,offset _r_addD 
    int 21h
    mov ax,0
    mov dx,0
    mov bx,0
    mov al,_n1D
    mov bl,_n2D
    add al,bl
    add al,48
    cmp al,57
    jg edit_nombre
    mov dl,al
    mov ah,02h
    int 21h
    jmp endoper
    edit_nombre:
    sub al,58
    mov bl,49
    mov dl,bl
    mov _x,al
    mov ah,02h
    int 21h
    mov ax,0
    mov ah,02h
    mov dl,_x
    int 21h
    jmp endoper
    PROG_SOUSTRACTION_D:
    mov ah,09h
    mov dx,offset _r_subD 
    int 21h
    mov ax,0
    mov dx,0
    mov bx,0
    mov al,_n1D
    mov bl,_n2D
    cmp al,bl
    jl er_soustraction
    sub al,bl
    add al,48
    mov dl,al
    mov ah,02h
    int 21h
    jmp endoper
    PROG_MULTIPLICATION_D:
    mov ah,09h
    mov dx,offset _r_mulD 
    int 21h
    mov ax,0
    mov dx,0
    mov bx,0
    mov al,_n1D
    mov bl,_n2D
    mul bl
    add al,48
    mov dl,al
    mov ah,02h
    int 21h
    endoper:
    mov ah,09h
    mov dx,offset _quit_D 
    int 21h
    mov ah,01h
    int 21h
    cmp al,111
    je fin
    mov ah,09h
    mov dx,offset _returnligne 
    int 21h
    jmp start
    
    
    
    HEXADECIMAL:
    ;AFICHAGE DE TYPE DE CALCULATRICE 
    mov ah,09h
    mov dl,offset _title_1_H 
    int 21h
    ;AFICHAGE DE SAISIE DE NOMBRE 1 
    mov ah,09h
    mov dl,offset _qn1D 
    int 21h
    ;SAISIE DE NOMBRE 1 
    mov ah,01h
    int 21h
    sub al,48
    mov _n1D,al 
    ;AFICHAGE DE SAISIE DE NOMBRE 2 
    mov ah,09h
    mov dl,offset _qn2D 
    int 21h
    ;SAISIE DE NOMBRE 2 
    mov al,0
    mov ah,01h 
    int 21h 
    sub al,48
    mov _n2D,al 
    ;AFICHAGE DE MENU
    mov ah,09h
    mov dx,offset _menu_D 
    int 21h
    ;SAISIE DE CHOIX DE MENU 
    mov al,0
    mov ah,01h 
    int 21h 
    sub al,48
    cmp al,1
    je PROG_ADDITION_H
    cmp al,2
    je PROG_SOUSTRACTION_H
    cmp al,3
    je PROG_MULTIPLICATION_H 
    
    PROG_DIVISION_H:
    mov ah,09h
    mov dx,offset _r_divD 
    int 21h
    mov ax,0
    mov dx,0
    mov bx,0
    mov al,_n1D
    mov bl,_n2D
    cmp bl,0
    je er_division
    div bl
    add al,48
    mov dl,al
    mov ah,02h
    int 21h
    jmp endoperH
    PROG_ADDITION_H:
    mov ah,09h
    mov dx,offset _r_addD 
    int 21h
    mov ax,0
    mov dx,0
    mov bx,0
    mov al,_n1D
    mov bl,_n2D
    add al,bl
    add al,48
    cmp al,57
    jg edit_nombreH
    mov dl,al
    mov ah,02h
    int 21h
    jmp endoperH
    edit_nombreH:
    cmp al,63
    jg edit_nombre2H
    sub al,58
    add al,65
    mov dl,al
    mov ah,02h
    int 21h 
    jmp endoperH
    
    edit_nombre2H:
    mov ah,02h
    mov dl,49
    int 21h
    
    mov ah,02h
    add al,1
    mov dl,al
    int 21h
    jmp endoperH
    
    PROG_SOUSTRACTION_H:
    mov ah,09h
    mov dx,offset _r_subD 
    int 21h
    mov ax,0
    mov dx,0
    mov bx,0
    mov al,_n1D
    mov bl,_n2D
    cmp al,bl
    jl er_soustraction
    sub al,bl
    add al,48
    mov dl,al
    mov ah,02h
    int 21h
    jmp endoperH
    PROG_MULTIPLICATION_H:
    mov ah,09h
    mov dx,offset _r_mulD 
    int 21h
    mov ax,0
    mov dx,0
    mov bx,0
    mov al,_n1D
    mov bl,_n2D
    mul bl
    add al,48
    mov dl,al
    mov ah,02h
    int 21h
    endoperH:
    mov ah,09h
    mov dx,offset _quit_D 
    int 21h
    mov ah,01h
    int 21h
    cmp al,111
    je fin
    mov ah,09h
    mov dx,offset _returnligne 
    int 21h
    jmp start
    
    fin:
    ; exit to operating system.
    mov ax, 4c00h 
    int 21h    
ends
; set entry point and stop the assembler.
end start 
