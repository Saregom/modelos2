#include <iostream>
#include <string>
#include <algorithm>
#include <chrono>

// Función para sumar dos números grandes representados como strings
std::string sumaNúmerosGrandes(const std::string& num1, const std::string& num2) {
    std::string resultado;
    int carry = 0;
    int longitud1 = num1.length();
    int longitud2 = num2.length();
    int maxLongitud = std::max(longitud1, longitud2);

    // Asegurarse de que ambas cadenas tengan la misma longitud
    std::string num1Extendido = std::string(maxLongitud - longitud1, '0') + num1;
    std::string num2Extendido = std::string(maxLongitud - longitud2, '0') + num2;

    // Sumar dígito a dígito
    for (int i = maxLongitud - 1; i >= 0; --i) {
        int suma = (num1Extendido[i] - '0') + (num2Extendido[i] - '0') + carry;
        resultado.push_back((suma % 10) + '0');
        carry = suma / 10;
    }

    if (carry) {
        resultado.push_back(carry + '0');
    }

    // Revertir el resultado porque se construye al revés
    std::reverse(resultado.begin(), resultado.end());
    return resultado;
}

// Función para restar dos números grandes representados como strings
std::string restaNúmerosGrandes(const std::string& num1, const std::string& num2) {
    std::string resultado;
    bool negativo = false;

    std::string num1Extendido = num1;
    std::string num2Extendido = num2;

    if (num1.length() < num2.length()) {
        num1Extendido = std::string(num2.length() - num1.length(), '0') + num1;
        num2Extendido = num2;
        negativo = true;
    } else if (num2.length() < num1.length()) {
        num2Extendido = std::string(num1.length() - num2.length(), '0') + num2;
        num1Extendido = num1;
    } else {
        num1Extendido = num1;
        num2Extendido = num2;
    }

    int borrow = 0;
    for (int i = num1Extendido.length() - 1; i >= 0; --i) {
        int resta = (num1Extendido[i] - '0') - (num2Extendido[i] - '0') - borrow;
        if (resta < 0) {
            resta += 10;
            borrow = 1;
        } else {
            borrow = 0;
        }
        resultado.push_back(resta + '0');
    }

    // Revertir el resultado porque se construye al revés
    std::reverse(resultado.begin(), resultado.end());
    // Eliminar ceros a la izquierda
    resultado.erase(0, resultado.find_first_not_of('0'));

    if (resultado.empty()) {
        resultado = "0";
    }

    if (negativo) {
        resultado = "-" + resultado;
    }

    return resultado;
}

std::string multiplicaNúmerosGrandes(const std::string& num1, const std::string& num2) {
    if (num1 == "0" || num2 == "0") {
        return "0";
    }

    int n1 = num1.length();
    int n2 = num2.length();
    
    // El tamaño máximo del resultado será la suma de las longitudes de los dos números
    std::string resultado(n1 + n2, '0');
    
    // Multiplicación de dígito a dígito
    for (int i = n1 - 1; i >= 0; --i) {
        int carry = 0;
        int n1Digito = num1[i] - '0';
        
        for (int j = n2 - 1; j >= 0; --j) {
            int n2Digito = num2[j] - '0';
            int suma = n1Digito * n2Digito + (resultado[i + j + 1] - '0') + carry;
            carry = suma / 10;
            resultado[i + j + 1] = (suma % 10) + '0';
        }
        resultado[i] += carry;  // Ajuste del acarreo en la posición correcta
    }
    
    // Eliminar ceros a la izquierda
    size_t inicio = resultado.find_first_not_of('0');
    if (inicio != std::string::npos) {
        resultado = resultado.substr(inicio);
    } else {
        resultado = "0";
    }
    
    return resultado;
}

// Función para dividir dos números grandes representados como strings
std::string divideNúmerosGrandes(const std::string& num1, const std::string& num2) {
    if (num2 == "0") {
        throw std::invalid_argument("División por cero");
    }

    std::string resultado;
    std::string resto;
    for (char digito : num1) {
        resto += digito;
        int cociente = 0;

        while (resto.length() > num2.length() || (resto.length() == num2.length() && resto >= num2)) {
            resto = restaNúmerosGrandes(resto, num2);
            ++cociente;
        }

        resultado += cociente + '0';
    }

    // Eliminar ceros a la izquierda
    size_t inicio = resultado.find_first_not_of('0');
    if (inicio != std::string::npos) {
        resultado = resultado.substr(inicio);
    } else {
        resultado = "0";
    }
    
    return resultado;
}

int main() {
    std::string num1, num2;
    char operacion;

    std::cout << "Ingrese el primer numero: ";
    std::cin >> num1;
    std::cout << "Ingrese el segundo numero: ";
    std::cin >> num2;
    std::cout << "Ingrese la operacion (1(suma), 2(resta), 3(multiplicacion), 4(division)): ";
    std::cin >> operacion;

    auto start = std::chrono::high_resolution_clock::now(); // Iniciar temporizador

    try {
        std::string resultado;
        switch (operacion) {
            case '1':
                resultado = sumaNúmerosGrandes(num1, num2);
                break;
            case '2':
                resultado = restaNúmerosGrandes(num1, num2);
                break;
            case '3':
                resultado = multiplicaNúmerosGrandes(num1, num2);
                break;
            case '4':
                resultado = divideNúmerosGrandes(num1, num2);
                break;
            default:
                std::cerr << "Operación no válida." << std::endl;
                return 1;
        }
        std::cout << "Resultado: " << resultado << std::endl;
    } catch (const std::invalid_argument& e) {
        std::cerr << e.what() << std::endl;
        return 1;
    }

    auto end = std::chrono::high_resolution_clock::now(); // Finalizar temporizador
    auto elapsed = std::chrono::duration_cast<std::chrono::nanoseconds>(end - start);
    std::cout << "Tiempo de ejecucion: " << elapsed.count() << " ns" << std::endl;

    return 0;
}
