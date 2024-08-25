#include <iostream>
#include <chrono>  // Para medir el tiempo de ejecución

using namespace std;
using namespace std::chrono;

bool esValido(int tablero[9][9], int fila, int columna, int num) {
    // Verifica si el número ya está en la fila
    for (int i = 0; i < 9; i++) {
        if (tablero[fila][i] == num) {
            return false;
        }
    }

    // Verifica si el número ya está en la columna
    for (int i = 0; i < 9; i++) {
        if (tablero[i][columna] == num) {
            return false;
        }
    }

    // Verifica si el número ya está en el subcuadro 3x3
    int inicioFila = (fila / 3) * 3;
    int inicioColumna = (columna / 3) * 3;
    for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
            if (tablero[inicioFila + i][inicioColumna + j] == num) {
                return false;
            }
        }
    }

    return true;
}

bool resolverSudoku(int tablero[9][9]) {
    for (int fila = 0; fila < 9; fila++) {
        for (int columna = 0; columna < 9; columna++) {
            if (tablero[fila][columna] == 0) {  // Si la celda está vacía
                for (int num = 1; num <= 9; num++) {
                    if (esValido(tablero, fila, columna, num)) {
                        tablero[fila][columna] = num;

                        if (resolverSudoku(tablero)) {
                            return true;
                        }

                        tablero[fila][columna] = 0;  // Backtrack
                    }
                }
                return false;  // No se encontró un número válido, se retrocede
            }
        }
    }
    return true;  // El Sudoku ha sido resuelto
}

void imprimirTablero(int tablero[9][9]) {
    for (int fila = 0; fila < 9; fila++) {
        for (int columna = 0; columna < 9; columna++) {
            cout << tablero[fila][columna] << " ";
        }
        cout << endl;
    }
}

int main() {
    int tablero[9][9] = {
        {5, 3, 0, 0, 7, 0, 0, 0, 0},
        {6, 0, 0, 1, 9, 5, 0, 0, 0},
        {0, 9, 8, 0, 0, 0, 0, 6, 0},
        {8, 0, 0, 0, 6, 0, 0, 0, 3},
        {4, 0, 0, 8, 0, 3, 0, 0, 1},
        {7, 0, 0, 0, 2, 0, 0, 0, 6},
        {0, 6, 0, 0, 0, 0, 2, 8, 0},
        {0, 0, 0, 4, 1, 9, 0, 0, 5},
        {0, 0, 0, 0, 8, 0, 0, 7, 9}
    };

    // Medir el tiempo de ejecución
    auto start = high_resolution_clock::now();
    auto stop = 0;
    if resolver_sudoku(tablero):
        stop = high_resolution_clock::now();
        imprimirTablero(tablero);
    else:
        print("No se encontró solución.")
        cout << "No se encontró solución." << endl;

    auto duration = duration_cast<nanoseconds>(stop - start);
    cout << "Tiempo de ejecución en C++: " << duration.count() / 1e9 << " segundos" << endl;

    return 0;
}
