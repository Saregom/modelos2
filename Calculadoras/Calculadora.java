import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.Scanner;

public class Calculadora {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        System.out.println("Bienvenido a la calculadora.");

        int contadorOperaciones = 0; // Contador de operaciones

        while (true) {
            // Pedir al usuario que ingrese dos números grandes
            System.out.print("Ingresa el primer número: ");
            BigDecimal numero1 = scanner.nextBigDecimal();

            System.out.print("Ingresa el segundo número: ");
            BigDecimal numero2 = scanner.nextBigDecimal();

            // Pedir al usuario que seleccione la operación
            System.out.println("Elige la operación que deseas realizar:");
            System.out.println("1. Suma");
            System.out.println("2. Resta");
            System.out.println("3. Multiplicación");
            System.out.println("4. División");
            System.out.print("Ingresa el número de la operación (1/2/3/4): ");
            int operacion = scanner.nextInt();

            BigDecimal resultado = null;

            // Iniciar temporizador justo antes de la operación
            long inicio = System.nanoTime();

            // Realizar la operación seleccionada
            switch (operacion) {
                case 1:
                    resultado = numero1.add(numero2);
                    System.out.println("El resultado de la suma es: " + resultado);
                    break;
                case 2:
                    resultado = numero1.subtract(numero2);
                    System.out.println("El resultado de la resta es: " + resultado);
                    break;
                case 3:
                    resultado = numero1.multiply(numero2);
                    System.out.println("El resultado de la multiplicación es: " + resultado);
                    break;
                case 4:
                    if (numero2.compareTo(BigDecimal.ZERO) != 0) {
                        // Definir la escala (precisión) y el método de redondeo
                        resultado = numero1.divide(numero2, 50, RoundingMode.HALF_UP); // Escala de 50 dígitos
                        System.out.println("El resultado de la división es: " + resultado);
                    } else {
                        System.out.println("Error: División por cero no es permitida.");
                    }
                    break;
                default:
                    System.out.println("Operación no válida. Inténtalo de nuevo.");
            }

            // Terminar temporizador justo después de la operación
            long fin = System.nanoTime();
            long duracion = (fin - inicio) / 1_000_000; // Convertir a milisegundos

            // Incrementar el contador de operaciones
            contadorOperaciones++;

            // Mostrar el tiempo de ejecución y el contador de operaciones
            System.out.println("Tiempo de ejecución: " + duracion + " ms");
            System.out.println("Número de operaciones realizadas: " + contadorOperaciones);

            // Preguntar si desea realizar otra operación
            System.out.print("¿Deseas realizar otra operación? (s/n): ");
            char continuar = scanner.next().charAt(0);
            if (continuar != 's' && continuar != 'S') {
                System.out.println("Gracias por usar la calculadora. ¡Hasta luego!");
                break;
            }
        }

        scanner.close();
    }
}
