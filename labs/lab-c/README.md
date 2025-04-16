# Repaso de C - Manejo de Notas

Este lab tiene como objetivo reforzar conceptos de programación segura en C a través de la implementación de un gestor de notas simple. El programa proporcionado contiene vulnerabilidades comunes en código C que deberán ser identificadas y corregidas.

## Objetivos

* Identificar y corregir vulnerabilidades de seguridad en código C.
* Implementar buenas prácticas de manejo de memoria.
* Prevenir buffer overflows.
* Evitar vulnerabilidades con format strings.
* Implementar correcta validación de entrada.
* Evitar el uso de variables globales.

## Funcionalidades

El programa debe implementar las siguientes funcionalidades manejando la memoria correctamente:

- **Agregar una nota**: Con titulo y cuerpo.
- **Ver una nota**: Consultando por indice.
- **Eliminar una nota**: Borrar por indice y liberar la memoria correctamente
- **Guardar las notas**: Las notas deben guardarse en un archivo llamado `notes.dat` para que puedan ser recuperadas en futuras ejecuciones.
- **Cargar las notas**: El programa debe cargar las notas desde `notes.dat` al iniciar.

## Sugerencias

* Reemplaza las funciones inseguras por alternativas seguras (Por ejemplo gets() → fgets()).
* Implementa una estructura para mantener el estado del programa en lugar de variables globales.
* Verifica el return de todas las funciones que pueden fallar (malloc, fopen, etc.).
* Usa free() consistentemente.
* Valida el input del usuario antes de procesarlas.

## Pruebas

   **El script requiere tener Valgrind instalado para funcionar correctamente**

   ```bash
   ./test_script.sh
   ```

   El script compilará el programa, ejecutará los tests y te mostrará los resultados.

## Como se puede ampliar el lab?

* Implementa una función de búsqueda de notas por palabra clave
* Reemplaza el array estático por una estructura de datos dinámica