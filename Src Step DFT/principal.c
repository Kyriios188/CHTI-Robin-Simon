

#include "DriverJeuLaser.h"

extern short int LeSignal;
extern int DFT_ModuleAuCarre(short int * signal, int k);
int tab[64];

int main(void)
{

// ===========================================================================
// ============= INIT PERIPH (faites qu'une seule fois)  =====================
// ===========================================================================

// Apr�s ex�cution : le coeur CPU est clock� � 72MHz ainsi que tous les timers
CLOCK_Configure();


	
	

//============================================================================	
	

	for (int i = 0; i < 65; i++) {
		tab[i] = DFT_ModuleAuCarre(&LeSignal, i);
	}
while	(1)
	{
	}
}

