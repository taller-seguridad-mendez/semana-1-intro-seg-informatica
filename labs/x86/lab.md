# Lab x86

En este lab repasaremos conceptos fundamentales de la arquitectura x86, mediante algunos programas escritos en NASM (Netwide Assembler). NASM es un assembler x86 con sintaxis Intel-like. Requiere ser bastante explícitos con lo que se desea hacer, por lo que lo consideramos de alto valor educacional. Además, tiene extendido uso en el contexto de la seguridad informática.

Nos enfocaremos en la arquitectura i386, es decir, la variante de 32 bits de x86. Provee un gran punto de entrada, permitiendo explorar los conceptos esenciales sin considerar las sutilezas de x86-64.

## Lab 0: Hola mundo!

### Dependencias

Es necesario contar con `nasm` para ensamblar los programas. Además, es necesario poder compilar los programas a i386. Si el dispositivo ya es x86 32 bits, listo. Si no, será necesario contar con `gcc-multilib` para poder compilar de forma cruzada (_cross-compile_), a i386.

Suponiendo que la plataforma donde se realizan los labs está basada en Debian, se pueden instalar mediante:

```sh
sudo apt install -y nasm gcc-multilib
```

Alternativamente se puede ejecutar:

`make deps`

### Ensamblar y linkear

Comenzaremos con el archivo `hello_world.asm`. No nos preocupemos en entenderlo del todo por ahora, pero básicamente muestra por pantalla "Hello, world!".

En primer lugar, es necesario ensamblar el programa y convertirlo en un archivo compilado de 32 bits para Linux:

```sh
nasm -f elf32 hello_world.asm -o hello_world.o
```

Luego, se linkea para obtener un ejecutable que podemos correr:

```sh
ld -m elf_i386 hello_world.o -o hello_world
```

Finalmente, ejecutar:

```sh
./hello_world
```

Se pide modificar el archivo `hello_world.asm` para obtener "¡Hola, mundo!" por consola.


TODO: docker con todo?
TODO: otras plataformas?



# Bibliografía
