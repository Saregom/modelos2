def ask_numbers():
    numeros = []
    print(input("Ingrese los numeros uno por uno (enter), para terminar escriba 0"))
    
    while True:
        entrada = input("Ingrese un numero (o 'fin' para terminar)")
        if entrada.lower() == 'fin':
            break
        try:
            numero = int(entrada)
            numeros.append(numero)
        except ValueError:
            print("Por favor ingrese un numero")

    return numeros



#termine para probar
#