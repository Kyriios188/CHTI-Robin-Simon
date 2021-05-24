	PRESERVE8
	THUMB   
		

; ====================== zone de r�servation de donn�es,  ======================================
;Section RAM (read only) :
;On cr�� de nouvelles sections au programme
;Ici l'area s'appelle mesdata qui contient du data en readonly
	area    mesdata,data,readonly


;Section RAM (read write):
;On cr�� une nouvelle section appell�e maram qui contient du data en read et write.
	area    maram,data,readwrite


;On cr�� l'adresse VarTime qui contient 4 octets de 0.
VarTime	dcd 0

	
; ===============================================================================================
	
;constantes (�quivalent du #define en C)
TimeValue	equ 900000

; On peut maintenant utiliser Delay_100ms dans d'autres programmes
; Synonyme de GLOBAL
	EXPORT Delay_100ms ; la fonction Delay_100ms est rendue publique donc utilisable par d'autres modules.
	EXPORT VarTime

;Section ROM code (read only) :		
	area    moncode,code,readonly
		


; REMARQUE IMPORTANTE 
; Cette mani�re de cr�er une temporisation n'est clairement pas la bonne mani�re de proc�der :
; - elle est peu pr�cise
; - la fonction prend tout le temps CPU pour... ne rien faire...
;
; Pour autant, la fonction montre :
; - les boucles en ASM
; - l'acc�s �cr/lec de variable en RAM
; - le m�canisme d'appel / retour sous programme
;
; et donc poss�de un int�r�t pour d�buter en ASM pur

; On d�fini la proc�dure Delay_100ms (proc�dure = fonction qui ne renvoie rien)
Delay_100ms proc
		;on charge l'adresse VarTime (4 octets de 0) dans le registre r0.
	    ldr r0,=VarTime  		  
		;on charge la constante TimeValue=900000 dans le registre r1
		ldr r1,=TimeValue
		;on place la valeur de TimeValue � l'adresse VarTime (les 4 octets de 0)
		str r1,[r0]
		
BoucleTempo	
		ldr r1,[r0] ;On place VarTime dans r1, soit 900000 au d�but et 900000-n � la boucle n.			
						
		subs r1,#1
		str  r1,[r0] ;on met � jour VarTime
		bne	 BoucleTempo ;on jump � BoucleTempo si le dernier calcul qu'on a fait renvoie "not equal"
						 ;ici on va boucler jusqu'� ce que r1 soit �gal � 0.
			
		bx lr ; On sort du programme en utilisant le contexte sauvegard� dans le load register (on repart � l'instruction GPIOB_Set(1); dans le programme C.
		endp ; fin de la proc�dure
		
		
	END	