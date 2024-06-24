#include <stdio.h>
#include <stdlib.h>

#include "funciones.h"

#define LOCAL 4
#define TRIMESTRE 4

///////////////////
//------FUNCIONES (.c)------

//------MENU-1--------
void menu_principal(int matriz[LOCAL][TRIMESTRE]) {
    int opcion;
    printf("       MENU     ");
    printf("\n--------------------\n");
    printf("1. Ingresar DATOS\n");
    printf("2. Mostrar Informe\n");
    printf("3. Mostrar local con mas ventas por trimestre.\n");
    printf("4. Borrar 'Archivo' y comenzar uno nuevo\n");
    printf("\n");
    printf("0. SALIR\n");
    printf("--------------------\n");
    printf("\n");
    printf("Seleccione una opcion: ");
    scanf("%i", &opcion);

    switch(opcion)
    {
        case 1:
                seleccion_Local_Trimestre(matriz);
        break;

        case 2:
                leerArchivo(matriz);
                imprimir_matriz(matriz);
                system("pause");
                system("cls");
                menu_principal(matriz);
        break;

        case 3:
                system("cls");
                leerArchivo(matriz);
                local_mas_ventas(matriz);
                system("pause");
                system("cls");
                menu_principal(matriz);
        break;

        case 4:
                borrarArchivo();
                menu_principal(matriz);
        break;

        case 0:
                salir_del_programa();
        break;

        default:
                system("cls");
                printf("ERROR.\n");
                printf("Ingrese una opcion valida.\n");
                printf("\n");
                menu_principal(matriz);
        break;
    }
}

//---------------------------------------------------------------
//------------------------SELECCION-----------------------------

int seleccion_Local_Trimestre(int matriz[LOCAL][TRIMESTRE]) {
    system("cls");
    printf("--------------------------------\n");
    printf("\n");

    int numLocal, numTrimestre;

    printf("Ingrese el LOCAL (1 al 4): ");
    fflush(stdin);
    scanf("%i", &numLocal);

    if (numLocal == 0) {
        system("cls");
        menu_principal(matriz);
        return 0;
    }

    validarLocal(numLocal, matriz);

    printf("Ingrese el TRIMESTRE (1 al 4): ");
    fflush(stdin);
    scanf("%i", &numTrimestre);

    validarTrimestre(numTrimestre, matriz);

    int montoIngresado;

    printf("--------------------------------\n");
    printf("Local: %i  | Trimestre: %i\n", numLocal, numTrimestre);
    printf("Ingrese el monto: ");
    scanf("%i", &montoIngresado);
    validar_montoIngresado(montoIngresado, numLocal - 1, numTrimestre - 1, matriz);

    seleccion_Local_Trimestre(matriz);
}

//---------------------------------------------------------------

//---------------------------VALIDACIÓN-------------------------
void validarLocal(int numLocal, int matriz[LOCAL][TRIMESTRE]) {
    if((numLocal >= 1) && (numLocal <= 4)) {
      // NADA
    } else {
        printf("-------------------------------\n");
        printf("|INGRESE UN 'LOCAL' VALIDO PORFAVOR.|\n");
        printf("-------------------------------\n");
        getchar();
        printf("\n");
        printf("\n");
        seleccion_Local_Trimestre(matriz);
    }
}
//---------------

void validarTrimestre(int numTrimestre, int matriz[LOCAL][TRIMESTRE]) {
    if((numTrimestre >= 1) && (numTrimestre <= 4)) {
       // NADA
    } else {
        system("cls");
        printf("-------------------------------\n");
        printf("|INGRESE UN 'TRIMESTRE' VALIDO PORFAVOR.|\n");
        printf("-------------------------------\n");
        getchar();
        printf("\n");
        printf("\n");
        seleccion_Local_Trimestre(matriz);
    }
}
//---------------

void validar_montoIngresado(int montoIngresado, int numLocal, int numTrimestre, int matriz[LOCAL][TRIMESTRE]) {
    if(montoIngresado < 0) {
        system("cls");
        printf("-------------------------------\n");
        printf("INGRESE UN VALOR MAYOR A 0\n");
        printf("--------------------------------\n");
        getchar();
        printf("\n");
        printf("\n");
        seleccion_Local_Trimestre(matriz);
    } else {
        printf("-------------------------------\n");
        matriz[numLocal][numTrimestre] += montoIngresado;
        escribirArchivo(numLocal + 1, numTrimestre + 1, montoIngresado);
    }
}

//---------------------------------------------------------------

//----------------IMPRESION---------------------

void imprimir_matriz(int matriz[LOCAL][TRIMESTRE]) {
    system("cls");
    int vector_Local[LOCAL] = {0, 0, 0, 0};
    int vector_Trimestre[TRIMESTRE] = {0, 0, 0, 0};

    printf("\n");

    printf("            | TRIMESTRE 1  | TRIMESTRE 2  | TRIMESTRE 3  | TRIMESTRE 4  | TOTAL_LOCAL  |\n");

    // IMPRESIÓN + OPERACION (VECTORES DE SUMA)
    for (int i = 0; i < LOCAL; i++) {
        printf("LOCAL %d     |", i + 1);

        for (int j = 0; j < TRIMESTRE; j++) {
            vector_Local[i] += matriz[i][j];
            vector_Trimestre[j] += matriz[i][j];
            printf("     %04d     |", matriz[i][j]);
        }
        printf("     %04d     |\n", vector_Local[i]);
    }

    int total_t = 0;

    printf("TOTAL_TR    |");

    for (int j = 0; j < TRIMESTRE; j++) {
        printf("     %04d     |", vector_Trimestre[j]);
    }

    // TOTAL OPERACION
    for (int i = 0; i < LOCAL; i++) {
        total_t += vector_Local[i];
    }

    printf("     %04d     |\n", total_t);

    printf("\n");
}

//---------------

void local_mas_ventas(int matriz[LOCAL][TRIMESTRE]) {
    int max_venta;
    int local_max;

    printf("\n");
    printf("----------------------------------------------------------------------\n");
    printf("||  ");
    printf("TRIMESTRE 1  ");
    printf("||  ");
    printf("TRIMESTRE 2  ");
    printf("||  ");
    printf("TRIMESTRE 3  ");
    printf("||  ");
    printf("TRIMESTRE 4  ");
    printf("||");
    printf("\n");


    for (int j = 0; j < TRIMESTRE; j++)
    {
        max_venta = 0;
        local_max = 0;

        for (int i = 0; i < LOCAL; i++)
        {
            if (matriz[i][j] > max_venta)
            {
                max_venta = matriz[i][j];
                local_max = i + 1;
            }
        }

        if (local_max==0)
        {
            printf("||       x       ",local_max);
        }
        else
        {
            printf("||       %i       ",local_max);
        }
    }
    printf("||");

    printf("\n");
    printf("----------------------------------------------------------------------\n");
    printf("\n");
}

//----------------FUNCIONES ARCHIVO---------------------
void escribirArchivo(int numLocal, int numTrimestre, int montoIngresado) {
    FILE *file = fopen("informe.txt", "a");
    if (file != NULL) {
        fprintf(file, "Local %d - Trimestre %d: %d\n", numLocal, numTrimestre, montoIngresado);
        fclose(file);
    } else {
        printf("Error al abrir el archivo 'informe.txt'.\n");
    }
}

void leerArchivo(int matriz[LOCAL][TRIMESTRE]) {
    FILE *file = fopen("informe.txt", "r");
    if (file == NULL) {
        printf("Error al abrir el archivo 'informe.txt'. Asegúrese de que el archivo exista.\n");
        return;
    }

    // Reiniciar la matriz antes de cargar los datos
    for(int i = 0; i < LOCAL; i++) {
        for(int j = 0; j < TRIMESTRE; j++) {
            matriz[i][j] = 0;
        }
    }

    int numLocal, numTrimestre, montoIngresado;
    while (fscanf(file, "Local %d - Trimestre %d: %d\n", &numLocal, &numTrimestre, &montoIngresado) == 3) {
        matriz[numLocal - 1][numTrimestre - 1] += montoIngresado;
    }

    fclose(file);
}

void borrarArchivo() {
    FILE *file = fopen("informe.txt", "w");
    if (file != NULL) {
        fclose(file);
    }
    printf("\n");
    system("cls");
    printf("El archivo se vacio correctamente.\n");
    printf("\n");
    system("pause");
    system("cls");
}

void inicio_valores_0(int matriz[LOCAL][TRIMESTRE])
{
    for(int i=0;i<4;i++)
    {
        for(int j=0;j<TRIMESTRE;j++)
        {
            matriz[i][j]=0;
        }
    }
}

void salir_del_programa() {
    exit(0);
}
//---------------

//---------------------------------------------------------------
