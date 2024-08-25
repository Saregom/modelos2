package sudokus;
/*
* Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
*/

/**
 *
* @author santi
*/
class Sudoku {
    public static boolean esValido(int[][] tablero, int fila, int columna, int num) {
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

    public static boolean resolverSudoku(int[][] tablero) {
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

    public static void imprimirTablero(int[][] tablero) {
        for (int fila = 0; fila < 9; fila++) {
            for (int columna = 0; columna < 9; columna++) {
                System.out.print(tablero[fila][columna] + " ");
            }
            System.out.println();
        }
    }

    public static void main(String[] args) {
        int[][] tablero = {
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

        long startTime = System.nanoTime();
        long endTime = 0;
        if (resolverSudoku(tablero)) {
            endTime = System.nanoTime();
            imprimirTablero(tablero);
        } else {
            System.out.println("No se encontró solución.");
        }
        
        System.out.println("Tiempo de ejecución: " + (endTime - startTime) / 1e9 + " segundos");
    }
}

