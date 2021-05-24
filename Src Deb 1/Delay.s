	PRESERVE8
	THUMB   
		

; ====================== zone de réservation de données,  ======================================
;Section RAM (read only) :
;On créé de nouvelles sections au programme
;Ici l'area s'appelle mesdata qui contient du data en readonly
	area    mesdata,data,readonly


;Section RAM (read write):
;On créé une nouvelle section appellée maram qui contient du data en read et write.
	area    maram,data,readwrite


;On créé l'adresse VarTime qui contient 4 octets de 0.
VarTime	dcd 0

	
; ===============================================================================================
	
;constantes (équivalent du #define en C)
TimeValue	equ 900000

; On peut maintenant utiliser Delay_100ms dans d'autres programmes
; Synonyme de GLOBAL
	EXPORT Delay_100ms ; la fonction Delay_100ms est rendue publique donc utilisable par d'autres modules.
	EXPORT VarTime

;Section ROM code (read only) :		
	area    moncode,code,readonly
		


; REMARQUE IMPORTANTE 
; Cette manière de créer une temporisation n'est clairement pas la bonne manière de procéder :
; - elle est peu précise
; - la fonction prend tout le temps CPU pour... ne rien faire...
;
; Pour autant, la fonction montre :
; - les boucles en ASM
; - l'accés écr/lec de variable en RAM
; - le mécanisme d'appel / retour sous programme
;
; et donc possède un intérêt pour débuter en ASM pur

; On défini la procédure Delay_100ms (procédure = fonction qui ne renvoie rien)
Delay_100ms proc
		;on charge l'adresse VarTime (4 octets de 0) dans le registre r0.
	    ldr r0,=VarTime  		  
		;on charge la constante TimeValue=900000 dans le registre r1
		ldr r1,=TimeValue
		;on place la valeur de TimeValue à l'adresse VarTime (les 4 octets de 0)
		str r1,[r0]
		
BoucleTempo	
		ldr r1,[r0] ;On place VarTime dans r1, soit 900000 au début et 900000-n à la boucle n.			
						
		subs r1,#1
		str  r1,[r0] ;on met à jour VarTime
		bne	 BoucleTempo ;on jump à BoucleTempo si le dernier calcul qu'on a fait renvoie "not equal"
						 ;ici on va boucler jusqu'à ce que r1 soit égal à 0.
			
		bx lr ; On sort du programme en utilisant le contexte sauvegardé dans le load register (on repart à l'instruction GPIOB_Set(1); dans le programme C.
		endp ; fin de la procédure
		
		
	END	