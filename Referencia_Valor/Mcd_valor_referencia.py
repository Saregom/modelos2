def euclides_valor(a, b):   
    if b > a:
        a, b = b, a

    while b != 0:
        a, b = b, a % b 
        
    return a
    
def euclides_referencia(num_list):   
    if num_list[1] > num_list[0]:
        c = num_list[0]
        num_list[0] = num_list[1]
        num_list[1] = c

    while num_list[1] != 0:
        num_list[0], num_list[1] = num_list[1], num_list[0] % num_list[1] 

if __name__ == "__main__":
    a = 1
    b = 2
    
    a, b = b, a
    print(a, b)

    print('\nCalcular el MCD por el algoritmo de euclides\n')
    num1 = int(input('Ingresa el primer numero: '))
    num2 = int(input('Ingresa el segundo numero: '))

    print('\n---- Paso por valor ----')
    print(f"El mcd entre {num1} y {num2} es: ", euclides_valor(num1,num2))


    print('\n---- Paso por referencia ----')
    num_list = [num1, num2]
    euclides_referencia(num_list)

    print(f"El mcd es: ", num_list[0], '\n')
