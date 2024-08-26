import time

# Verificar si el numero es jugable
def playable_num(sudoku, row, column, number):
    # Verificar si el numero esta en la fila o en la columna
    for i in range(9):
        if sudoku[row][i] == number or sudoku[i][column] == number:
            return False

    # Verifica si el número esta en el submatriz 3x3
    for i in range(3):
        for j in range(3):
            if sudoku[(row//3)*3 + i][(column//3)*3 + j] == number:
                return False
    return True

# resolver sudoku
def solve(sudoku):
    for row in range(9):
        for column in range(9):
            if sudoku[row][column] == 0:
                for number in range(1, 10):
                    if playable_num(sudoku, row, column, number):
                        sudoku[row][column] = number
                        if solve(sudoku): return True
                        sudoku[row][column] = 0 # si no hay numeros disponibles en la celda, se reinicia
                return False 
    return True

if __name__ == '__main__':
    # sudoku inicial
    board1 = [
        [9, 0, 0, 0, 4, 5, 0, 0, 0],
        [0, 0, 0, 0, 6, 0, 0, 0, 0],
        [0, 8, 6, 0, 0, 0, 0, 2, 0],
        [4, 0, 7, 1, 0, 0, 0, 0, 2],
        [3, 5, 0, 4, 0, 8, 0, 6, 1],
        [6, 0, 0, 0, 0, 7, 3, 0, 4],
        [0, 4, 0, 0, 0, 0, 2, 1, 0],
        [0, 0, 0, 0, 5, 0, 0, 0, 0],
        [0, 0, 0, 3, 7, 0, 0, 0, 5]
    ]

    board2 = [
        [9, 0, 0, 0, 4, 5, 0, 0, 0],
        [0, 0, 0, 0, 6, 0, 0, 0, 0],
        [0, 8, 6, 0, 0, 0, 0, 2, 0],
        [4, 0, 7, 1, 0, 0, 0, 0, 2],
        [3, 5, 0, 4, 0, 8, 0, 6, 1],
        [6, 0, 0, 0, 0, 7, 3, 0, 4],
        [0, 4, 0, 0, 0, 0, 2, 1, 0],
        [0, 0, 0, 0, 5, 0, 0, 0, 0],
        [0, 0, 0, 3, 7, 0, 0, 0, 5]
    ]

    sudoku = board1

    start_time = time.perf_counter()
    solved_sudoku = solve(sudoku)
    end_time = time.perf_counter()

    if solved_sudoku:
        # Impresion sudoku resuelto
        for i, row in enumerate(sudoku):
            if i % 3 == 0: print(" -" * 13)
            str = ''
            for j, number in enumerate(row):
                if j % 3 == 0: str += f' |'
                str += f' {number}'
            print(str, '|')
        print(" -" * 13)

    else:
        print("No existe solucion")

    print(f"Tiempo de ejecucion del algoritmo: {(end_time - start_time)*1000} milisegundos")