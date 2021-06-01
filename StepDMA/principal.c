

#include "DriverJeuLaser.h"


extern short int LeSignal;
extern int DFT_ModuleAuCarre(short int * signal, int k);
int tab[64];
short int mon_signal[64];
int score[6];


void callback_systick(void)
{
	Start_DMA1(64);
	Wait_On_End_Of_DMA1();
	Stop_DMA1;
	for (int i = 0; i < 64; i++) {
		tab[i] = DFT_ModuleAuCarre(mon_signal, i);
	}
	if (tab[17] > 0xFFFF) {
		score[0] = score[0]+1;
	} else if (tab[18] > 0xFFFF) {
		score[1] = score[1]+1;
	} else if (tab[19] > 0xFFFF) {
		score[2] = score[2]+1;
	} else if (tab[20] > 0xFFFF) {
		score[3] = score[3]+1;
	} else if (tab[23] > 0xFFFF) {
		score[4] = score[4]+1;
	} else if (tab[24] > 0xFFFF) {
		score[5] = score[5]+1;
	}
}

int main(void)
{

// ===========================================================================
// ============= INIT PERIPH (faites qu'une seule fois)  =====================
// ===========================================================================

// Après exécution : le coeur CPU est clocké à 72MHz ainsi que tous les timers
CLOCK_Configure();
Systick_Period_ff(360000);
Systick_Prio_IT(1, &callback_systick);  //rajouter le nom de fonction à la place du 0! 
SysTick_On;
SysTick_Enable_IT;
	
unsigned int ticks = 3*72; //on calcule la période en ticks de l'interruption
	
Timer_1234_Init_ff(TIM2, ticks);
	
Init_TimingADC_ActiveADC_ff( ADC1, 72 );

Single_Channel_ADC( ADC1, 2 );
	
Init_Conversion_On_Trig_Timer_ff( ADC1, TIM2_CC2, 225 );

Init_ADC1_DMA1( 0, mon_signal );
//============================================================================	
	


while	(1)
	{
	}
}

