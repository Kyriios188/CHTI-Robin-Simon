

#include "DriverJeuLaser.h"

extern int PeriodeSonMicroSec;
extern void init(void);
extern void CallbackSon(void);
int ticks;

int main(void)
{
ticks = PeriodeSonMicroSec*72;
// ===========================================================================
// ============= INIT PERIPH (faites qu'une seule fois)  =====================
// ===========================================================================

// Apr�s ex�cution : le coeur CPU est clock� � 72MHz ainsi que tous les timers
CLOCK_Configure();

// configuration du Timer 4 en d�bordement 100ms
	
//** Placez votre code l� ** // 
	
Timer_1234_Init_ff(TIM4, ticks); //On choisit (91*10^-6)*72000000
	
// Activation des interruptions issues du Timer 4
// Association de la fonction � ex�cuter lors de l'interruption : CallbackSon
// cette fonction (si �crite en ASM) doit �tre conforme � l'AAPCS
Active_IT_Debordement_Timer(TIM4, 2, CallbackSon);
	
// configuration de PortB.1 (PB1) en sortie push-pull
GPIO_Configure(GPIOB, 1, OUTPUT, OUTPUT_PPULL);

PWM_Init_ff(TIM3, 3, 720);
GPIO_Configure(GPIOB, 0, OUTPUT, ALT_PPULL);
	

//============================================================================	
	
	
while	(1)
	{
		for (int i = 0; i < 10000000; i++) {
				if (i == 0) {
						init();
				}
		}
	}
}

