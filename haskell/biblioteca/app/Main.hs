{- 
 - Proyecto Final Modelos de programacion II - Programa Biblioteca
 - Autores:
    - Santiago Reyes Gomez 20221020098
    - Nicolás Romero Rodríguez 20222020023
    - Santiago Buitrago 20221020085
-}

module Main (main) where

import qualified Data.Map as Map
import Data.List (isInfixOf)
import Text.CSV (parseCSV)
import Text.Regex.Posix ((=~))
import System.IO (hFlush, stdout)

-- Definicion de los tipos de datos
type UsuarioID = Int
type LibroID = Int
type PrestamoID = Int

data Usuario = Usuario {
    usuarioId :: UsuarioID,
    nombre :: String,
    apellido :: String,
    edad :: Int,
    genero :: String,
    correo :: String
} deriving (Show)

data Libro = Libro {
    libroId :: LibroID,
    titulo :: String,
    autor :: String,
    generoLibro :: String,
    anio :: Int
} deriving (Show)

data Prestamo = Prestamo {
    prestamoId :: PrestamoID,
    usuarioIdFK :: UsuarioID,
    libroIdFK :: LibroID,
    fechaPrestamo :: String,
    fechaEntrega :: String,
    estado :: String,
    comentario :: String
} deriving (Show)

type TablaUsuarios = Map.Map UsuarioID Usuario
type TablaLibros = Map.Map LibroID Libro
type TablaPrestamos = Map.Map PrestamoID Prestamo

-- Funciones para parsear los CSVs y devolver una Objeto del tipo de Tabla
crearUsuario :: [String] -> Usuario
crearUsuario [idStr, nombreNuevo, apellidoNuevo, edadStr, generoNuevo, correoNuevo] =
    Usuario (read idStr) nombreNuevo apellidoNuevo (read edadStr) generoNuevo correoNuevo
crearUsuario _ = error "Formato de usuario incorrecto"

crearLibro :: [String] -> Libro
crearLibro [idStr, tituloNuevo, autorNuevo, generoNuevo, anioStr] =
    Libro (read idStr) tituloNuevo autorNuevo generoNuevo (read anioStr)
crearLibro _ = error "Formato de libro incorrecto"

crearPrestamo :: [String] -> Prestamo
crearPrestamo [idStr, usuarioIdStr, libroIdStr, fechaPrestamoNuevo, fechaEntregaNuevo, estadoNuevo, comentarioNuevo] =
    Prestamo (read idStr) (read usuarioIdStr) (read libroIdStr) fechaPrestamoNuevo fechaEntregaNuevo estadoNuevo comentarioNuevo
crearPrestamo _ = error "Formato de prestamo incorrecto"

-- Funciones para convertir las tablas a Map
convertirATablaUsuarios :: [[String]] -> TablaUsuarios
convertirATablaUsuarios = Map.fromList . map (\u -> (usuarioId (crearUsuario u), crearUsuario u))

convertirATablaLibros :: [[String]] -> TablaLibros
convertirATablaLibros = Map.fromList . map (\l -> (libroId (crearLibro l), crearLibro l))

convertirATablaPrestamos :: [[String]] -> TablaPrestamos
convertirATablaPrestamos = Map.fromList . map (\p -> (prestamoId (crearPrestamo p), crearPrestamo p))


----------------- Funcionalidades de app -----------------
-- Buscar usuarios por libro
buscarUsuarioPorCorreo :: TablaUsuarios -> String -> Maybe Usuario
buscarUsuarioPorCorreo usuarios correoIngresado = 
    case filter (\u -> correo u == correoIngresado) (Map.elems usuarios) of
        [usuario] -> Just usuario
        _         -> Nothing

correoRegex :: String
correoRegex = "[a-zA-Z0-9+._-]+@[a-zA-Z-]+\\.[a-z]+"

esCorreoValido :: String -> Bool
esCorreoValido correoAVerificar = correoAVerificar =~ correoRegex

agregarPrestamo :: TablaUsuarios -> TablaLibros -> TablaPrestamos -> PrestamoID -> String -> LibroID -> String -> String -> String -> String -> Maybe TablaPrestamos
agregarPrestamo usuarios libros prestamos nuevoId correoIngresado lId fechaPrestamoNuevo fechaEntregaNuevo estadoNuevo comentarioNuevo
    | not (esCorreoValido correoIngresado) = Nothing  -- Validar formato del correo
    | otherwise =
        case buscarUsuarioPorCorreo usuarios correoIngresado of
            Nothing -> Nothing  -- El correo no existe en la tabla de usuarios
            Just usuario -> 
                if not (Map.member lId libros)
                then Nothing  
                else Just (Map.insert nuevoId (Prestamo nuevoId (usuarioId usuario) lId fechaPrestamoNuevo fechaEntregaNuevo estadoNuevo comentarioNuevo) prestamos)
--------

-- Buscar libros por nombre
buscarLibrosPorNombre :: TablaLibros -> String -> [Libro]
buscarLibrosPorNombre libros nombreParte = 
    filter (\libro -> nombreParte `isInfixOf` titulo libro) (Map.elems libros)

buscarUsuariosPorLibroNombre :: TablaUsuarios -> TablaLibros -> TablaPrestamos -> String -> [(Usuario, Prestamo, String)]
buscarUsuariosPorLibroNombre usuarios libros prestamos nombreParte = 
    let librosEncontrados = buscarLibrosPorNombre libros nombreParte
        idsLibros = map libroId librosEncontrados
        prestamosConLibros = filter (\prestamo -> libroIdFK prestamo `elem` idsLibros) (Map.elems prestamos)
    in map (\prestamo -> 
            let usuario = usuarios Map.! usuarioIdFK prestamo -- Obtener el usuario con el ID del prestamo
                libro = libros Map.! libroIdFK prestamo
            in (usuario, prestamo, titulo libro)
           ) prestamosConLibros
--------

-- Buscar y contar palabras en comentarios de prestamos para generar reporte
contarFrecuenciasPalabras :: [String] -> [String] -> [(String, Int)]
contarFrecuenciasPalabras palabras comentarios = 
    map (\palabra -> (palabra, contarCoincidencias palabra comentarios)) palabras
  where
    contarCoincidencias :: String -> [String] -> Int
    contarCoincidencias palabra = length . filter (\comentarioEvaluar -> comentarioEvaluar =~ palabra :: Bool)

--------

------------- Menu para interactuar con el usuario -------------
menu :: TablaUsuarios -> TablaLibros -> TablaPrestamos -> IO ()
menu usuarios libros prestamos = do
    putStrLn "\n-------- MENU --------"
    putStrLn "1. Buscar personas que poseen un libro"
    putStrLn "2. Ingresar nuevo prestamo"
    putStrLn "3. Obtener reporte de prestamos"
    putStrLn "0. Salir"
    putStr "Elige una opcion: "
    hFlush stdout
    opcion <- getLine

    case opcion of
        -- Buscar personas que poseen un libro
        "1" -> do
            putStr "Ingresa el nombre del libro o parte de este: "
            hFlush stdout
            nombreParcialLibro <- getLine

            let usuariosEncontrados = buscarUsuariosPorLibroNombre usuarios libros prestamos nombreParcialLibro 
            putStrLn "\nUsuarios que poseen el libro buscado:"
            mapM_ (\(usuario, prestamo, nombreLibro) -> do
                    putStrLn "------------------------------"
                    putStrLn $ "Usuario: " ++ nombre usuario ++ " " ++ apellido usuario
                    putStrLn $ "Correo: " ++ correo usuario
                    putStrLn $ "Libro: " ++ nombreLibro
                    putStrLn $ "Fecha Prestamo: " ++ fechaPrestamo prestamo
                    putStrLn $ "Fecha Entrega: " ++ fechaEntrega prestamo
                    putStrLn $ "Estado: " ++ estado prestamo
                    putStrLn $ "Comentario: " ++ comentario prestamo
                ) usuariosEncontrados 

            menu usuarios libros prestamos  -- Regresar al menu

        -- Ingresar nuevo prestamo
        "2" -> do
            putStr "Ingresa el correo del usuario: "; hFlush stdout
            correoIngresado <- getLine
            putStr "Ingresa el ID del libro: "
            hFlush stdout
            libroIdStr <- getLine
            let libroIdIngresado = read libroIdStr :: LibroID
            putStr "Ingresa la fecha de prestamo (YYYY-MM-DD): "
            hFlush stdout
            fechaPrestamoIngresada <- getLine
            putStr "Ingresa la fecha de entrega (YYYY-MM-DD): "
            hFlush stdout
            fechaEntregaIngresada <- getLine
            putStr "Agregar un comentario: "
            hFlush stdout
            comentarioIngresado <- getLine
            -- si comentario es vacio, reemplazar la variable comentarioIngresado por "Sin comentario"
            let comentarioIngresado2 = if comentarioIngresado == "" then "Sin comentario" else comentarioIngresado
            print comentarioIngresado2
            
            let nuevoPrestamoId = Map.size prestamos + 1  -- Generar un nuevo ID
            let resultado = agregarPrestamo usuarios libros prestamos nuevoPrestamoId correoIngresado libroIdIngresado fechaPrestamoIngresada fechaEntregaIngresada "En curso" comentarioIngresado2
            
            -- actualizar la tabla de prestamos e imprimmirla
            case resultado of
                Nothing -> do
                    putStrLn "Error al agregar el prestamo (correo invalido, no existe, o libro no existe)"
                    menu usuarios libros prestamos
                Just nuevaTablaPrestamo -> do
                    putStrLn "\nPrestamo agregado con exito!"
                    putStrLn "La tabla actualizada de prestamos es: "

                    mapM_ (\(_, prestamoMap) -> do
                            let usuario = usuarios Map.! usuarioIdFK prestamoMap
                            let libro = libros Map.! libroIdFK prestamoMap
                            putStrLn "------------------------------"
                            putStrLn $ "ID Prestamo: " ++ show (prestamoId prestamoMap)
                            putStrLn $ "Usuario: " ++ nombre usuario ++ " " ++ apellido usuario ++ ", id:" ++ show (usuarioId usuario)
                            putStrLn $ "Correo: " ++ correo usuario
                            putStrLn $ "Libro: " ++ titulo libro ++ ", id:" ++ show (libroId libro)
                            putStrLn $ "Fecha Prestamo: " ++ fechaPrestamo prestamoMap
                            putStrLn $ "Fecha Entrega: " ++ fechaEntrega prestamoMap
                            putStrLn $ "Estado: " ++ estado prestamoMap
                            putStrLn $ "Comentario: " ++ comentario prestamoMap
                        ) (Map.toList nuevaTablaPrestamo)
                    
                    menu usuarios libros nuevaTablaPrestamo -- se pasa nuevaTablaPrestamo para "actualizar" la tabla de prestamos

        -- Obtener reporte de prestamos
        "3" -> do
            print prestamos
            let comentarios = map comentario (Map.elems prestamos)
            let buenasPalabras = ["bueno", "buena", "buen", "eficiente", "excelente", "rapido", "rapida"]
            let malasPalabras = ["malo", "mala", "mal", "deficiente", "tardado", "lento", "lenta"]

            let frecuenciasCalificacionesBuenas  = contarFrecuenciasPalabras buenasPalabras comentarios
            let frecuenciasCalificacionesMalas  = contarFrecuenciasPalabras malasPalabras comentarios

            putStrLn "\nNumero de calificaciones positivas:"
            mapM_ (\(palabra, frecuencia) -> putStrLn $ palabra ++ ": " ++ show frecuencia) frecuenciasCalificacionesBuenas
            putStrLn "\nNumero de calificaciones negativas:"
            mapM_ (\(palabra, frecuencia) -> putStrLn $ palabra ++ ": " ++ show frecuencia) frecuenciasCalificacionesMalas

            menu usuarios libros prestamos  -- Regresar al menu

        -- Salir del programa
        "0" -> putStrLn "Programa finalizado."
        _   -> do
            putStrLn "Opcion no valida. Intenta de nuevo."
            menu usuarios libros prestamos  -- Regresar al menu


------------- Ejecucion del programa -------------
main :: IO ()
main = do
    putStrLn "\n\n-------- APP BIBLIOTECA  --------"
    -- Cargar archivos CSV
    usuariosCSV <- readFile "app/data/Usuarios.csv"
    librosCSV <- readFile "app/data/Libros.csv"
    prestamosCSV <- readFile "app/data/Prestamos.csv"

    -- Parsear los CSVs
    let usuariosParsed = parseCSV "app/data/Usuarios.csv" usuariosCSV
    let librosParsed = parseCSV "app/data/Libros.csv" librosCSV
    let prestamosParsed = parseCSV "app/data/Prestamos.csv" prestamosCSV

    case (usuariosParsed, librosParsed, prestamosParsed) of
        (Right usuarios, Right libros, Right prestamos) -> do
            let usuariosTabla = convertirATablaUsuarios usuarios
            let librosTabla = convertirATablaLibros libros
            let prestamosTabla = convertirATablaPrestamos prestamos

            menu usuariosTabla librosTabla prestamosTabla

        _ -> putStrLn "Error al parsear los CSVs"


