# Repaso de C - Manejo de Notas

## Descripción

En este laboratorio vas a terminar de implementar y probar un programa en C que simula un gestor de notas. El programa permite agregar, visualizar, eliminar, guardar y cargar notas desde un archivo. El objetivo de este ejercicio es practicar el uso de punteros, la gestión de memoria dinámica y mejorar las prácticas de seguridad en la programación.

## Requisitos

1. **Manejo de punteros:** Usar punteros correctamente para gestionar las notas.
2. **Gestión de memoria dinámica:** Debes usar `malloc` y `free` correctamente para reservar y liberar memoria.
3. **Manejo de strings:** El codigo contiene funciones que manejan strings de forma insegura.
4. **Comprobación de errores**

## Funcionalidades

El programa debe implementar las siguientes funcionalidades manejando la memoria correctamente:

- **Agregar una nota**: Con titulo y cuerpo.
- **Ver una nota**: Consultando por indice.
- **Eliminar una nota**: Borrar por indice y liberar la memoria correctamente
- **Guardar las notas**: Las notas deben guardarse en un archivo llamado `notes.dat` para que puedan ser recuperadas en futuras ejecuciones.
- **Cargar las notas**: El programa debe cargar las notas desde `notes.dat` al iniciar.

## Pruebas

Para ayudarte a verificar que tu implementación está funcionando correctamente, proporcionamos un script de pruebas. El script realiza varios tests sobre el programa:

1. **Uso básico**: Verifica que se puedan agregar, ver y borrar notas correctamente.
2. **Buffer overflow**: Prueba si el programa es vulnerable a buffer overflows.
3. **Manipulación con strings**: Verifica si el programa es vulnerable a fallos de seguridad relacionados con strings.
4. **Uso de memoria ya liberada**: Comprueba si el programa permite el acceso a memoria después de haberla liberado.
5. **Valgrind**: Se ejecuta una prueba con `valgrind` para asegurarse de que no haya fugas de memoria.

## Pruebas
   ```bash
   ./test.sh
   ```

   El script compilará el programa, ejecutará los tests y te mostrará los resultados.

