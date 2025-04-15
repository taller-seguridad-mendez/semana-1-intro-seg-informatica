# Lab x86

En este lab repasaremos conceptos fundamentales de la arquitectura x86, mediante algunos programas escritos en NASM (Netwide Assembler). NASM es un assembler x86 con sintaxis Intel-like. Requiere ser bastante explícitos con lo que se desea hacer, por lo que lo consideramos de alto valor educacional. Además, tiene extendido uso en el contexto de la seguridad informática.

Nos enfocaremos en la arquitectura i386, es decir, la variante de 32 bits de x86. Provee un gran punto de entrada, permitiendo explorar los conceptos esenciales sin considerar las sutilezas de x86-64.

## Hola mundo!

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

### Makefile

Se provee un Makefile para facilitar la generación de los ejecutables. Buildear y linkear `hello_world` con el Makefile:

```sh
make hello_world
```

Luego, ejecutar.

## Software interrupts y syscalls

x86 soporta la familia de instrucciones `INT`. `INT n` genera una llamada a una "interrupt procedure". Cada `n` sirve de índice a la Interrupt Descriptor Table (IDT) del procesador. `INT 0` a `INT 21` son interrupciones y excepciones predefinidas. `INT 22` a `INT 255` sirven para interrupciones por software.

TODO: enlace al manual Intel (capítulo 6.5 - interrupts and exceptions).
TODO: enlace al manual Intel (anexo 2A, INT n/INTO/INT3/INT1).
TODO: enlace a la definición de la IDT en el Linux kernel.

Linux define `INT 0x80` como la entrada para las system calls. Se carga el número de syscall en el registro `eax`. La tabla de syscalls para x86 32 bits mapea los códigos de cada syscall a su correspondiente nombre y "entry point". TODO: enlace a la tabla de syscalls. Si las syscall requiriese argumentos, estos se deben cargar en registros predeterminados, que se puede consultar en el código de entrada para syscalls en x86 32 bits (TODO: enlace a entry_32.S). Estos son:

```
eax     syscall_number
ebx     arg1
ecx     arg2
edx     arg3
esi     arg4
edi     arg5
ebp     arg6
```

### `sys_exit` y exit code

En este lab llamaremos a la syscall "exit" (ver `man 2 exit`). Esta recibe un "status code" a ser devuelto al proceso padre. En `sys_exit.asm` se carga 1 en `eax`, correspondiente a la syscall "exit". Se carga el "status" o "exit code" en `ebx`. Luego, se llama al interrupt `int 0x80` para ejecutar la syscall:

```
_start:
	mov eax, 1
	mov ebx, 1
	int 0x80
```

1. Buildear y ejecutar `sys_exit`.
2. En la consola, consultar el exit code con `echo $?`.

A continuación, se pide modificar el código para que el status code devuelto al proceso ejecutante sea 0.

### TODO: otro lab con syscalls




TODO: docker con todo?
TODO: otras plataformas?



# Bibliografía
