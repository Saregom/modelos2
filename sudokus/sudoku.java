/**
*
* @author santi
*/

class Sudoku {
    public static boolean playable_num(int[][] sudoku, int row, int column, int number) {
        for(int i=0; i<9; i++){
            if (sudoku[row][i] == number || sudoku[i][column] == number){
                return false;
            }
        }

        for(int i=0; i<3; i++){
            for(int j=0; j<3; j++){
                if(sudoku[(row/3)*3 + i][(column/3)*3 + j] == number){
                    return false;
                }
            }
        }
        return true;
    }

    public static boolean solve(int[][] sudoku){
        for(int row=0; row<9; row++){
            for(int column=0; column<9; column++){
                if(sudoku[row][column] == 0){ 
                    for(int number = 1; number <= 9; number++){
                        if(playable_num(sudoku, row, column, number)){
                            sudoku[row][column] = number;
                            if(solve(sudoku)) return true;
                            sudoku[row][column] = 0; 
                        }
                    }
                    return false; 
                }
            }
        }
        return true;
    }

    public static void main(String[] args){
        // int[][] board1 = {
        //     {9, 0, 0, 0, 4, 5, 0, 0, 0},
        //     {0, 0, 0, 0, 6, 0, 0, 0, 0},
        //     {0, 8, 6, 0, 0, 0, 0, 2, 0},
        //     {4, 0, 7, 1, 0, 0, 0, 0, 2},
        //     {3, 5, 0, 4, 0, 8, 0, 6, 1},
        //     {6, 0, 0, 0, 0, 7, 3, 0, 4},
        //     {0, 4, 0, 0, 0, 0, 2, 1, 0},
        //     {0, 0, 0, 0, 5, 0, 0, 0, 0},
        //     {0, 0, 0, 3, 7, 0, 0, 0, 5}
        // };

        int[][] board2 = {
            {1, 0, 6, 9, 0, 0, 0, 0, 0},
            {0, 3, 0, 0, 5, 0, 1, 2, 8},
            {0, 0, 0, 0, 0, 0, 4, 0, 0},
            {8, 0, 0, 0, 0, 5, 0, 0, 4},
            {0, 0, 0, 0, 0, 0, 0, 0, 7},
            {0, 2, 0, 0, 8, 0, 0, 1, 3},
            {0, 4, 0, 0, 0, 0, 5, 0, 0},
            {0, 0, 0, 0, 1, 0, 7, 0, 0},
            {0, 0, 3, 0, 0, 6, 0, 4, 1}
        };

        int[][] sudoku = board2;

        long startTime = System.nanoTime();
        boolean solved_sudoku = solve(sudoku);
        long endTime = System.nanoTime();

        if(solved_sudoku){
            for(int row=0; row<9; row++) {
                if(row % 3 == 0) System.out.print(" -".repeat(13) + "\n");
                for(int column=0; column<9; column++) {
                    if(column % 3 == 0) System.out.print(" |");
                    System.out.print(" " + sudoku[row][column]);
                }
                System.out.print(" |\n");
            }
            System.out.print(" -".repeat(13) + "\n");
        }else{
            System.out.println("No existe solucion");
        }
        
        System.out.println("Tiempo de ejecucion del algoritmo: " + (endTime - startTime) / 1e6 + " milisegundos");
    }
}