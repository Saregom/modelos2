import time

def es_valido(sudoku, fila, columna, num):
    # Verifica si el número ya está en la fila
    for i in range(9):
        if sudoku[fila][i] == num:
            return False

    # Verifica si el número ya está en la columna
    for i in range(9):
        if sudoku[i][columna] == num:
            return False

    # Verifica si el número ya está en el subcuadro 3x3
    inicio_fila = (fila // 3) * 3
    inicio_columna = (columna // 3) * 3
    for i in range(3):
        for j in range(3):
            if sudoku[inicio_fila + i][inicio_columna + j] == num:
                return False

    return True

def resolver_sudoku(sudoku):
    for fila in range(9):
        for columna in range(9):
            if sudoku[fila][columna] == 0:  # Si la celda está vacía
                for num in range(1, 10):
                    if es_valido(sudoku, fila, columna, num):
                        sudoku[fila][columna] = num

                        if resolver_sudoku(sudoku):
                            return True

                        sudoku[fila][columna] = 0  # Backtrack

                return False  # No se encontró un número válido, se retrocede

    return True  # El Sudoku ha sido resuelto

def imprimir_sudoku(sudoku):
    for fila in sudoku:
        print(" ".join(str(num) for num in fila))

# Ejemplo de uso
sudoku = [
    [5, 3, 0, 0, 7, 0, 0, 0, 0],
    [6, 0, 0, 1, 9, 5, 0, 0, 0],
    [0, 9, 8, 0, 0, 0, 0, 6, 0],
    [8, 0, 0, 0, 6, 0, 0, 0, 3],
    [0, 0, 0, 8, 0, 3, 0, 0, 1],
    [0, 0, 0, 0, 2, 0, 0, 0, 6],
    [0, 6, 0, 0, 0, 0, 2, 8, 0],
    [0, 0, 0, 4, 1, 9, 0, 0, 5],
    [0, 0, 0, 0, 8, 0, 0, 7, 9]
]

start_time = time.time()
if resolver_sudoku(sudoku):
    end_time = time.time()
    imprimir_sudoku(sudoku)
else:
    print("No se encontró solución.")

print(f"Tiempo de ejecución: {end_time - start_time} segundos.")