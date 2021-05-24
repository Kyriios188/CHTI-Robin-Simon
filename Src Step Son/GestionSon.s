	PRESERVE8
	THUMB   
		

; ====================== zone de réservation de données,  ======================================
;Section RAM (read only) :
	area    mesdata,data,readonly


;Section RAM (read write):
	area    maram,data,readwrite
	export sortieson


index dcd 0
sortieson dcd 0
; ===============================================================================================
	extern divide
	
	export CallbackSon
	export init
	extern Son
	extern LongueurSon
	include Driver/DriverJeuLaser.inc
		
;Section ROM code (read only) :		
	area    moncode,code,readonly
; écrire le code ici		

init proc
	ldr r0, =index
	ldr r1, [r0]
	mov r1, #0
	str r1, [r0]
	bx lr
	endp

CallbackSon proc
	ldr r1, =index
	ldr r0, [r1]
	ldr r3, =LongueurSon
	ldr r3, [r3]
	cmp r0, r3  ;if index = longueur son
	beq fin
	ldr r2, =Son
	ldrsh r3, [r2, r0, lsl #1]
	add r0, r0, #1
	str r0, [r1]

	add r3, r3, #32768
	mov r2, #720
	mul r3, r3, r2
	lsr r3, #16
	
	ldr r2, =sortieson
	str r3, [r2]
	mov r0, r3

	push {lr}
	bl PWM_Set_Value_TIM3_Ch3
	pop {lr}

fin		
	bx lr
	endp
	END	