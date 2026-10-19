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
-- Se inicializa el par acumulador con el primer elemento como máximo y mínimo,
-- y una función auxiliar recursiva recorre el resto de la lista elemento a
-- elemento actualizando ambos extremos en cada paso en un único pase O(n).
mayorYMenor :: Ord a => [a] -> Maybe (a, a)
mayorYMenor []     = Nothing
mayorYMenor (x:xs) = Just (aux x x xs)
  where
    aux :: Ord a => a -> a -> [a] -> (a, a)
    aux mx mn []     = (mx, mn)
    aux mx mn (y:ys) =
      let mx' = if y > mx then y else mx
          mn' = if y < mn then y else mn
      in aux mx' mn' ys

-- A3
leerHora :: String -> Either String (Int, Int)
leerHora = undefined

duracion :: String -> String -> Either String Int
duracion = undefined

-- =====================================================================
-- Parte B: orden superior.
-- Prohibido: recursión explícita (ninguna función de esta parte, ni sus
-- auxiliares, puede llamarse a sí misma).
-- =====================================================================

-- B1
promedioSobreUmbral :: Double -> [Double] -> Maybe Double
promedioSobreUmbral = undefined

-- B2
movimientosCaballo :: (Int, Int) -> [(Int, Int)]
movimientosCaballo = undefined

enDosSaltos :: (Int, Int) -> Int
enDosSaltos = undefined

-- B3
miMap :: (a -> b) -> [a] -> [b]
miMap = undefined

miFilter :: (a -> Bool) -> [a] -> [a]
miFilter = undefined

miFoldl :: (b -> a -> b) -> b -> [a] -> b
miFoldl = undefined
