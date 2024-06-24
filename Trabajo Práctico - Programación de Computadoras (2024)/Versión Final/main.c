#include <stdio.h>
#include <stdlib.h>

#include "funciones.h"

#define LOCAL 4
#define TRIMESTRE 4


//------MAIN------
int main()
{
    int matriz[LOCAL][TRIMESTRE];

    inicio_valores_0(matriz);
    menu_principal(matriz);
    return 0;
}
//---------------
