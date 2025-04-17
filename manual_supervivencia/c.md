# Básico

## Estructura

```c
#include<stdio.h> // headers

int main()
{
    // Your code here

    return(0);
}
```

## Comentarios

```c
// Comentario de una línea
```

```c
/* Comentario de varias líneas
   Comentario de varias líneas */
```

## Tipos de datos

```c
int a; // Entero
float b; // Decimal
double c; // Decimal de doble precisión
char d; // Caracter
char e[10]; // Arreglo de caracteres (string)
```

# Operadores

## Aritméticos

```c
a + b; // Suma
a - b; // Resta
a * b; // Multiplicación
a / b; // División
a % b; // Módulo
```

## Relacionales

```c
a > b; // Mayor que
a < b; // Menor que
a >= b; // Mayor o igual que
a <= b; // Menor o igual que
a == b; // Igual a
a != b; // Diferente de
```

## Lógicos

```c
a && b; // AND lógico
a || b; // OR lógico
!a; // NOT lógica
```

## Bitwise

```c
a & b; // AND bit a bit
a | b; // OR bit a bit
a ^ b; // XOR bit a bit
a << b; // Shift a la izquierda
a >> b; // Shift a la derecha
```

## Asignación

```c
a = b; // Asignación simple
a += b; // Operación y asignación, válido para todos los operadores aritméticos, lógicos y bitwise.
a++; // Posincremento
a--; // Posdecremento
++a; // Preincremento
--a; // Predecremento
```


# Instrucciones de control

## Condicionales

### If

```c
if (/* condition */)
{
    /* code */
}
```

### If-else

```c
if (/* condition */)
{
    /* code */
}
else
{
    /* code */
}
```

### If-else if-else

```c
if (/* condition */)
{
    /* code */
}
else if (/* condition */)
{
    /* code */
}
else
{
    /* code */
}
```

### Switch

```c
switch (/* expression */)
{
    case /* value */:
        /* code */
        break;
    case /* value */:
        /* code */
        break;
    default:
        /* code */
}
```

## Bucles

### For

```c
for (/* initialization */; /* condition */; /* increment/decrement */)
{
    /* code */
}
```

### While

```c
while (/* condition */)
{
    /* code */
}
```

### Do-while

```c
do
{
    /* code */
} while (/* condition */);
```

### Break y continue

```c
break; // Sale del bucle
continue; // Salta a la siguiente iteración del bucle
```

# Funciones
```c
// Declaración de función
tipo_retorno nombre_funcion(tipo_parametro1 nombre_parametro1, tipo_parametro2 nombre_parametro2, ...)
{
    // Código de la función
    return valor_retorno; // Opcional
}
```

```c
// Llamada a la función
tipo_retorno variable = nombre_funcion(argumento1, argumento2, ...);
```

# Punteros

## Declaración

```c
tipo_dato *nombre_puntero; // Declaración de puntero
nombre_puntero = &variable; // Asignación de dirección de variable a puntero
*nombre_puntero = valor; // Asignación de valor a la dirección apuntada por el puntero
```

## Dereferenciación

```c
valor = *nombre_puntero; // Obtener el valor de la dirección apuntada por el puntero
```

# Estructuras

```c
struct nombre_estructura
{
    tipo_dato1 nombre_variable1;
    tipo_dato2 nombre_variable2;
    // ...
};
```

# Typedef

```c
typedef tipo_dato nombre_alias; // Crear un alias para un tipo de dato
```

# Uniones

```c
union nombre_union
{
    tipo_dato1 nombre_variable1;
    tipo_dato2 nombre_variable2;
    // ...
};
```

# Memoria dinámica

```c
#include<stdlib.h> // Para malloc y free
```

```c
// Asignación de memoria dinámica
puntero = (tipo_dato *)malloc(tamaño); // Asignar memoria
```

```c
// Liberar memoria dinámica
free(puntero); // Liberar memoria
```

```c
// Reasignar memoria dinámica
puntero = (tipo_dato *)realloc(puntero, nuevo_tamaño); // Reasignar memoria
```

```c
// Asignación de memoria dinámica para un arreglo
puntero = (tipo_dato *)malloc(tamaño * sizeof(tipo_dato)); // Asignar memoria para un arreglo
```


