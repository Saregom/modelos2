------------- 1) Implementar una función que transforma un número entero positivo en una cadena de caracteres que contiene los mismos dígitos, por ejemplo: pasarChar(321) = ”321”
pasarChar :: Int -> String
pasarChar = show



------------- 2) Dada una palabra determinar si es palíndromo o no. Si no lo es, convertirla a palíndromo en el menos número de pasos. (No hacer uso de función reverse
-- Se comparan los extremos de la palabra
checkPalindromo :: String -> Int -> Int -> String
checkPalindromo palabra i j
    | i >= j = palabra
    | palabra !! i == palabra !! j = checkPalindromo palabra (i + 1) (j - 1)
    | otherwise = ""

-- Convertir una palabra a palindromo
convertirAPalindromo :: String -> (String, Int)
convertirAPalindromo palabra = convertir palabra 0 (length palabra - 1) 0

-- Convertir y contar los pasos
convertir :: String -> Int -> Int -> Int -> (String, Int)
convertir palabra i j pasos
    | i >= j = (palabra, pasos)
    | palabra !! i == palabra !! j = convertir palabra (i + 1) (j - 1) pasos
    | otherwise =
        let nuevaPalabra = reemplazar palabra j (palabra !! i)
        in convertir nuevaPalabra (i + 1) (j - 1) (pasos + 1)

-- Reemplazar un carácter en una posición dada de una cadena
reemplazar :: String -> Int -> Char -> String
reemplazar palabra indice nuevoChar = take indice palabra ++ [nuevoChar] ++ drop (indice + 1) palabra

-- Funcion a ejecutar
main2 :: IO ()
main2 = do
    putStrLn "Ingresa una palabra: "
    input <- getLine
    let palabra = show input :: String
    if palabra == checkPalindromo palabra 0 (length palabra - 1)
        then putStrLn (palabra ++ " ya es un palindromo")
        else do
            let (palindromo, pasos) = convertirAPalindromo palabra
            putStrLn ("La palabra convertida a palindromo es: " ++ palindromo)
            putStrLn ("Numero de pasos tomados: " ++ show pasos)



------------- 3) Dado un texto corto, contar la cantidad de palabras del texto
contarPalabras :: String -> String
contarPalabras texto = "El texto tiene " ++ show (length (words texto)) ++ " palabras"