# CI-3661 — Laboratorio de Lenguajes de Programación I
## Tarea 1: Práctica de Haskell (Septiembre – Diciembre 2026)

- **Estudiante:** Stefano Casale
- **Carnet:** 19-10114
- **Profesor:** Leonardo López Almazán

Repositorio correspondiente a la solución de la Tarea 1.

---

### Estructura de archivos

- `Tarea1.hs`: Implementación de todas las funciones solicitadas en las Partes A y B.
- `PruebasTarea1.hs`: Batería de pruebas públicas provista por la cátedra.
- `traza.pdf`: Documento manuscrito escaneado con la resolución del Problema 7 (reducción por sustitución y justificación teórica).
- `README.md`: Descripción general del proyecto y documentación de funciones.

---

### Funciones implementadas

#### Parte A: Recursión explícita
Restricción: prohibido el uso de `map`, `filter`, `foldr`, `foldl`, listas por comprensión, `reverse` y funciones de orden superior.

- **`esPalindromo :: String -> Bool`**  
  Determina si una cadena es palíndromo ignorando caracteres no alfanuméricos y sin distinguir mayúsculas de minúsculas. Emplea funciones auxiliares con recursión estructural para limpiar la cadena (`limpiar`) e invertirla mediante acumulador de cola (`reverso`).

- **`mayorYMenor :: Ord a => [a] -> Maybe (a, a)`**  
  Calcula el par `(mayor, menor)` en un solo recorrido de la lista ($O(n)$). Inicializa ambos extremos con el primer elemento y consume la cola mediante una función recursiva auxiliar con guardias mutuamente excluyentes. Retorna `Nothing` si la lista está vacía.

- **`leerHora :: String -> Either String (Int, Int)`**  
  Interpreta una hora en formato `HH:MM` de 24 horas usando coincidencia de patrones sobre listas con literales. Valida que los cuatro caracteres sean dígitos con `isDigit` y que los valores estén en rango ($0 \le h \le 23$, $0 \le m \le 59$). Devuelve errores descriptivos mediante `Either`, priorizando el error de hora si ambos fallan.

- **`duracion :: String -> String -> Either String Int`**  
  Calcula la cantidad de minutos transcurridos desde una hora inicial hasta una final. Encadena el parseo de ambas horas usando `case`. Si la segunda hora es anterior a la primera, suma 1440 minutos para contemplar el cambio de día.

#### Parte B: Orden superior
Restricción: prohibida la recursión explícita en las funciones y sus auxiliares.

- **`promedioSobreUmbral :: Double -> [Double] -> Maybe Double`**  
  Promedia los valores de la lista estrictamente mayores que el umbral especificado. Realiza un solo recorrido con `foldl` acumulando una tupla `(suma, cuenta)`. Devuelve `Nothing` si la lista está vacía o si ningún elemento supera el umbral.

- **`movimientosCaballo :: (Int, Int) -> [(Int, Int)]`**  
  Genera las casillas válidas a las que puede saltar un caballo desde una posición dada dentro de un tablero de ajedrez ($1 \le r, c \le 8$). Utiliza una lista por comprensión con los desplazamientos ordenados crecientemente para que las coordenadas resultantes queden directamente en orden lexicográfico.

- **`enDosSaltos :: (Int, Int) -> Int`**  
  Calcula el número de casillas distintas alcanzables tras exactamente dos saltos del caballo. Compone los dos saltos mediante una lista por comprensión y elimina duplicados usando `foldr`.

- **`miMap :: (a -> b) -> [a] -> [b]`**  
  Aplica una función `f` sobre cada elemento de una lista, implementado exclusivamente mediante `foldr`.

- **`miFilter :: (a -> Bool) -> [a] -> [a]`**  
  Conserva los elementos que satisfacen un predicado `p`, implementado exclusivamente mediante `foldr`.

- **`miFoldl :: (b -> a -> b) -> b -> [a] -> b`**  
  Reproduce el comportamiento asociativo a la izquierda de `foldl` expresado en términos de `foldr`. Construye una composición de funciones acumuladoras que luego se aplica sobre el valor inicial `z`.

---

### Instrucciones de ejecución

Para compilar y verificar las pruebas públicas desde la terminal:

```powershell
runghc PruebasTarea1.hs
```
