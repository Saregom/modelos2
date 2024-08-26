import time

def calculadora():
    print("Bienvenido a la calculadora.")
    
    contador_operaciones = 0  # Contador de operaciones
    
    while True:
        # Pedir al usuario que ingrese dos números grandes
        numero1 = int(input("Ingresa el primer número: "))
        numero2 = int(input("Ingresa el segundo número: "))
        
        # Pedir al usuario que seleccione la operación
        print("Elige la operación que deseas realizar:")
        print("1. Suma")
        print("2. Resta")
        print("3. Multiplicación")
        print("4. División")
        operacion = input("Ingresa el número de la operación (1/2/3/4): ")
        
        # Iniciar temporizador justo antes de realizar la operación
        inicio = time.perf_counter()
        
        # Realizar la operación seleccionada
        if operacion == '1':
            resultado = numero1 + numero2
            print(f"El resultado de la suma es: {resultado}")
        elif operacion == '2':
            resultado = numero1 - numero2
            print(f"El resultado de la resta es: {resultado}")
        elif operacion == '3':
            resultado = numero1 * numero2
            print(f"El resultado de la multiplicación es: {resultado}")
        elif operacion == '4':
            if numero2 != 0:
                resultado = numero1 / numero2
                print(f"El resultado de la división es: {resultado}")
            else:
                print("Error: División por cero no es permitida.")
        else:
            print("Operación no válida. Inténtalo de nuevo.")
        
        # Terminar temporizador
        fin = time.perf_counter()
        duracion = (fin - inicio) * 1_000_000  # Duración en nanosegundos
        
        # Incrementar el contador de operaciones
        contador_operaciones += 1
        
        # Mostrar el tiempo de ejecución y el contador de operaciones
        print(f"Tiempo de ejecución: {duracion:.0f} ns")
        print(f"Número de operaciones realizadas: {contador_operaciones}")
        
        # Preguntar si desea realizar otra operación
        continuar = input("¿Deseas realizar otra operación? (s/n): ")
        if continuar.lower() != 's':
            print("Gracias por usar la calculadora. ¡Hasta luego!")
            break

# Ejecutar la calculadora
calculadora()
