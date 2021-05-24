

#include "DriverJeuLaser.h"
#include "GestionSon.h"
extern void CallbackSon(void);
extern int LongueurSon;
extern int indiceTableau;


int fenetrage(int val) {
	int retour = val + 32768;
	retour = retour *720/65535;
	return retour;
}


int main(void) {

	// ===========================================================================
	// ============= INIT PERIPH (faites qu'une seule fois)  =====================
	// ===========================================================================

	// Après exécution : le coeur CPU est clocké à 72MHz ainsi que tous les timers
	CLOCK_Configure();
	
	
	Timer_1234_Init_ff(TIM4, 6552);
	Active_IT_Debordement_Timer(TIM4, 2, CallbackSon);
	
	PWM_Init_ff(TIM3, 3, 720); // période de 10,42 us
	GPIO_Configure(GPIOB, 0, OUTPUT, ALT_PPULL);
	
	
	
	

	//============================================================================	
	
	
	while	(1) {
		if (indiceTableau == LongueurSon) {
			StartSon();
		}
	}
}

