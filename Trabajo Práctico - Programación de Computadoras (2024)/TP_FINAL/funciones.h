#define LOCAL 4
#define TRIMESTRE 4

///////////////////
//------PROTOTIPOS(.H)-----

//MENU
void menu_principal(int matriz[LOCAL][TRIMESTRE]);
//---------------------------------------------------------------


//SELECCION
int seleccion_Local_Trimestre(int matriz[LOCAL][TRIMESTRE]);
void ingresarMonto(int matriz[LOCAL][TRIMESTRE]);
//---------------------------------------------------------------


//VERIFICACION (¿SE INGRESO EL OTRO DATO?)
int validar_Local(int matriz[LOCAL][TRIMESTRE]);
void validar_Trimestre(int matriz[LOCAL][TRIMESTRE]);
void validar_montoIngresado(int montoIngresado,int numLocal, int numTrimestre, int matriz[LOCAL][TRIMESTRE]);
//---------------------------------------------------------------


//IMPRESION
void impresion_Final(int matriz[LOCAL][TRIMESTRE]);
void imprimir_matriz(int matriz[LOCAL][TRIMESTRE]);
void local_mas_ventas(int matriz[LOCAL][TRIMESTRE]);
//---------------------------------------------------------------




//FUNCIONES ARCHIVO
//Archivo_Escritura(numLocal,numTrimestre,montoIngresado);
void escribirArchivo(int numLocal, int numTrimestre, int montoIngresado);
//Archivo_Lectura();
void leerArchivo();
//Archivo_Vaciado();
void borrarArchivo();
//---------------------------------------------------------------



//AUX
void salir_del_programa();
void lineas_Texto();
void enter_para_continuar(int opcion);
//---------------------------------------------------------------
