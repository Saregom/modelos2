main :: IO ()
main = print "Ejercicios de Haskell"

-----------
-- 1) Dado un número n entero calcular la suma de sus dígitos

sumaDigitos :: Int -> Int
sumaDigitos 0 = 0
sumaDigitos n = (n `mod` 10) + sumaDigitos (n `div` 10)

-- Función a ejecutar
calcularSumaDigitos = do
    putStrLn "Ingresa un número:"
    input <- getLine
    let numero = read input :: Int
    print (sumaDigitos numero)

-----------
-- 2) Dado un número n entero calcular el producto de sus dígitos

productoDigitos :: Int -> Int
productoDigitos 0 = 0
productoDigitos n = productoAux n 1

-- Función auxiliar para manejar la multiplicación
productoAux :: Int -> Int -> Int
productoAux 0 acc = acc
productoAux n acc = productoAux (n `div` 10) (acc * (n `mod` 10))

-- Función a ejecutar
calcularProductoDigitos = do
    putStrLn "Introduce un número:"
    input <- getLine
    let numero = read input :: Int
    let resultado = if numero == 0 then 0 else productoDigitos numero
    putStrLn ("El producto de los dígitos es: " ++ show resultado)

-----------
-- 3) Convertir un numero de base 10 a base 2

-- funcion a ejecutar
decimalToBinary :: Int -> String
decimalToBinary 0 = "0"
decimalToBinary n = "El numero " ++ show n ++ " en  base 2 es: " ++ reverse (convert n)
    where
        convert 0 = ""
        convert x = show (x `mod` 2) ++ convert (x `div` 2)

-----------
-- 4) Determinar si dos segmentos de recta son perpendiculares (entradas las corrdenadas en 2 D de cada uno de los puntos que define los segmentos)

-- Calcular la pendiente
slope :: (Float, Float) -> (Float, Float) -> Float
slope (x1, y1) (x2, y2) = (y2 - y1) / (x2 - x1)

-- funcion a ejecutar
arePerpendicular :: (Float, Float) -> (Float, Float) -> (Float, Float) -> (Float, Float) -> String
arePerpendicular p1 p2 p3 p4 =
    if slope p1 p2 * slope p3 p4 == -1 
        then "Son perpendiculares" 
        else "No son perpendiculares"
