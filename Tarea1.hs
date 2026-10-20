-- =====================================================================
--  CI-3661 — Tarea 1 (Haskell) — Septiembre–Diciembre 2026
--
--  Nombre: Stefano Casale
--  Carnet: 19-10114
--
--  Declaración de uso de herramientas de IA (obligatoria, ver enunciado):
--  Se utilizó Antigravity (asistente de IA) para discusión conceptual,
--  análisis del enunciado, estructura de pruebas, asistencia en desarrollo
--  y análisis de robustez y casos borde en las funciones implementadas.
--
-- =====================================================================
--  No cambies el nombre del módulo ni la lista de exportación, ni las
--  firmas de las funciones. Puedes agregar todas las funciones auxiliares
--  que quieras. El único import permitido es Data.Char.
-- =====================================================================
module Tarea1
  ( esPalindromo
  , mayorYMenor
  , leerHora
  , duracion
  , promedioSobreUmbral
  , movimientosCaballo
  , enDosSaltos
  , miMap
  , miFilter
  , miFoldl
  ) where

import Data.Char (isAlphaNum, isDigit, toLower, digitToInt)

-- =====================================================================
-- Parte A: recursión explícita.
-- Prohibido: map, filter, foldr, foldl, listas por comprensión, reverse,
-- maximum, minimum, all, any y cualquier otra función de orden superior.
-- =====================================================================

-- A1
-- Limpia los caracteres no alfanumericos y los pasa a minusculas antes de
-- verificar la simetria de la cadena. Ambas operaciones usan recursion explicita.
esPalindromo :: String -> Bool
esPalindromo xs =
  let limpia = limpiar xs
  in limpia == reverso limpia
  where
    limpiar :: String -> String
    limpiar [] = []
    limpiar (c:cs)
      | isAlphaNum c = toLower c : limpiar cs
      | otherwise    = limpiar cs

    reverso :: [a] -> [a]
    reverso ys = revAux ys []
      where
        revAux :: [a] -> [a] -> [a]
        revAux [] acc     = acc
        revAux (z:zs) acc = revAux zs (z : acc)

-- A2
-- Explica aquí, en dos o tres líneas, por qué tu solución recorre la
-- lista una sola vez:
-- Se inicializan los extremos con la cabeza de la lista y la función auxiliar
-- consume la cola en un único pase inductivo O(n), usando guardias excluyentes
-- para actualizar (mayor, menor) sin necesidad de recorrer la lista de nuevo.
mayorYMenor :: Ord a => [a] -> Maybe (a, a)
mayorYMenor []     = Nothing
mayorYMenor (x:xs) = Just (aux x x xs)
  where
    aux :: Ord a => a -> a -> [a] -> (a, a)
    aux mx mn [] = (mx, mn)
    aux mx mn (y:ys)
      | y > mx    = aux y mn ys
      | y < mn    = aux mx y ys
      | otherwise = aux mx mn ys

-- A3
-- Parsea una hora en formato HH:MM verificando tamañoo, separador y digitos.
-- Valida los rangos de hora y minutos, priorizando el error de hora si ambos fallan.
leerHora :: String -> Either String (Int, Int)
leerHora [h1, h2, ':', m1, m2]
  | isDigit h1 && isDigit h2 && isDigit m1 && isDigit m2 =
      let h = digitToInt h1 * 10 + digitToInt h2
          m = digitToInt m1 * 10 + digitToInt m2
      in if h > 23 then
           Left "hora fuera de rango"
         else if m > 59 then
           Left "minutos fuera de rango"
         else
           Right (h, m)
  | otherwise = Left "formato inválido"
leerHora _ = Left "formato inválido"

-- Calcula la diferencia en minutos entre dos horas parseadas con leerHora.
-- Si la segunda hora es menor que la primera, se asume que paso la medianoche (+1440).
duracion :: String -> String -> Either String Int
duracion s1 s2 =
  case leerHora s1 of
    Left err1 -> Left err1
    Right (h1, m1) ->
      case leerHora s2 of
        Left err2 -> Left err2
        Right (h2, m2) ->
          let t1 = h1 * 60 + m1
              t2 = h2 * 60 + m2
              diff = t2 - t1
          in Right (if diff < 0 then diff + 1440 else diff)

-- =====================================================================
-- Parte B: orden superior.
-- Prohibido: recursión explícita (ninguna función de esta parte, ni sus
-- auxiliares, puede llamarse a sí misma).
-- =====================================================================

-- B1
-- Calcula el promedio de elementos estrictamente mayores al umbral usando un solo
-- foldl con tupla (suma, cuenta). Devuelve Nothing si no hay elementos que cumplan.
promedioSobreUmbral :: Double -> [Double] -> Maybe Double
promedioSobreUmbral umbral xs =
  let (suma, cuenta) = foldl paso (0.0, 0 :: Int) xs
  in if cuenta == 0
       then Nothing
       else Just (suma / fromIntegral cuenta)
  where
    paso :: (Double, Int) -> Double -> (Double, Int)
    paso (s, c) x
      | x > umbral = (s + x, c + 1)
      | otherwise  = (s, c)

-- B2
-- Genera mediante lista por comprension los desplazamientos validos del caballo,
-- produciendo las casillas directamente en orden lexicografico y dentro del tablero.
movimientosCaballo :: (Int, Int) -> [(Int, Int)]
movimientosCaballo (r, c) =
  [ (r + dr, c + dc)
  | (dr, dc) <- [ (-2, -1), (-2, 1)
                , (-1, -2), (-1, 2)
                , (1, -2),  (1, 2)
                , (2, -1),  (2, 1)
                ]
  , r + dr >= 1, r + dr <= 8
  , c + dc >= 1, c + dc <= 8
  ]

-- Obtiene todas las casillas alcanzables tras dos saltos consecutivos y
-- elimina duplicados aplicando foldr sobre la lista de destinos.
enDosSaltos :: (Int, Int) -> Int
enDosSaltos pos =
  let dosSaltos = [ p2 | p1 <- movimientosCaballo pos, p2 <- movimientosCaballo p1 ]
      unicos    = foldr (\x acc -> if elem x acc then acc else x : acc) [] dosSaltos
  in length unicos

-- B3
-- Aplica la funcion f a cada elemento conservando el orden mediante foldr.
miMap :: (a -> b) -> [a] -> [b]
miMap f = foldr (\x acc -> f x : acc) []

-- Filtra los elementos que satisfacen el predicado p mediante foldr.
miFilter :: (a -> Bool) -> [a] -> [a]
miFilter p = foldr (\x acc -> if p x then x : acc else acc) []

-- Simula la asociatividad a la izquierda de foldl componiendo funciones
-- mediante foldr, que luego se evaluan sobre el acumulador inicial z.
miFoldl :: (b -> a -> b) -> b -> [a] -> b
miFoldl f z xs = foldr paso id xs z
  where
    paso x g acc = g (f acc x)
