	PRESERVE8
	THUMB   
		

; ====================== zone de réservation de données,  ======================================
;Section RAM (read only) :
	area    mesdata,data,readonly


;Section RAM (read write):
	area    maram,data,readwrite
FlagCligno	dcd	0
; ===============================================================================================
	EXPORT timer_callback
	EXTERN GPIOB_Clear
	EXTERN GPIOB_Set
		
;Section ROM code (read only) :		
	area    moncode, code, readonly
		
; écrire le code ici		
timer_callback proc
	push {lr}
	mov r0, #1
	ldr r3,=FlagCligno
	ldr r1, [r3]
	
	cmp r1, #1
	bne vaut_zero ;si ça vaut pas 0

	subs r1, r1, #1
	str r1, [r3]
	bl GPIOB_Clear
	pop	{lr} ;bl va utiliser lr donc on stock lr dans la pile et on le retrouve
	bx lr
	
vaut_zero
	adds r1, r1, #1
	str r1, [r3]
	bl GPIOB_Set
	pop	{lr}
	bx lr
	;//
		
	endp
	END	