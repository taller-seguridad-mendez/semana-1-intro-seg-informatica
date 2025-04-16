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

## Operaciones aritméticas

Completar `arithmetic.asm` tal que el resultado final en `eax` sea 10.

## Registros de propósito general

### Registros de propósito general de 32 bits

En este lab cargaremos valores en los registros de propósito general. Luego los inspeccionaremos con `gdb` a medida que se ejecuta el programa.

1. Buildear `gpr`.
2. Ejecutar `gdb ./gpr`.
3. Configurar un breakpoint al inicio del programa con `break _start`.
4. Iniciar la ejecución con `run`.
5. La ejecución se detendrá en el símbolo `_start`. Inspeccionemos los registros con `info registers`. En este punto, los registros `eax` y `ebx` deberían contener el valor `0x0`.
6. Ejecutar una línea de código con `stepi`.
7. Inspeccionar los registros. Deben contener los valores que se hayan cargado.
8. Repetir los pasos 6 y 7 hasta finalizar la carga de los registros.
9. Finalizar la ejecución del programa con `continue`.

TODO: algún ejercicio con algún output pedido.

### Registros de propósito general de 16 y 8 bits

x86 cuenta con registros de 16 y 8 bits. Recordemos que estos no son independientes, sino que están superpuestos con los registros "más grandes". Por ejemplo, el registro `al` son los 8 LSB de `eax`. El registro `ah` son los bits 8-15 de `eax`. Además, estos 16 bits conforman el registro `ax`, que son los 16 LSB de `eax`. Es decir, alterar estos registros modifica el valor de los otros. Comprobemoslo con el programa `gpr_16_8`. En este programa, se busca modificar el valor de `eax`, modificando `ax`; y de `ebx`, modificando `bh` y `bl`.

1. Buildear y ejecutar `gpr_16_8` con `gdb`.
2. Configurar un breakpoint en `_start` y comenzar la ejecución del programa.
3. Inspeccionar los registros. `eax` y `ebx` estarán en 0.
4. Ejecutar una línea e inspeccionar los registros. Se puede observar cómo `eax` y `ebx` se van construyendo.
5. Repetir 4 hasta que `eax` y `ebx` sean `0xFFFFFFFF`.
6. Finalizar.

TODO: algún ejercicio.

## Registro `flags` y condition codes

El registro `FLAGS` de x86, (`EFLAGS` para 32 bits), contiene el estado del procesador en un determinado momento. Cada bit del registro representa el estado (verdadero o falso) de alguna condición. Por ejemplo, representando el resultado de alguna operación anterior, como las flags _overflow_, _carry_, _sign_ y _zero_, colectivamente llamados _condition codes_.

### Condition codes

En el siguiente lab ejecutaremos algunas operaciones aritméticas y observaremos cómo se modifican los bits del registro `EFLAGS` correspondientes.

1. Buildear y ejecutar `condition_codes` con `gdb`.
2. Configurar breakpoints en `_start`, `zf`, `cf`, `of` y `cf`.
3. Comenzar la ejecución del programa.
4. Inspeccionar el registro `eflags`.
5. Continuar la ejecución del programa.
6. Observar los cambios en el registro `eflags`.
7. Repetir 5 y 6 hasta agotar los breakpoints configurados.
8. Finalizar.

TODO: algún ejercicio que tenga que printear eflags y se testea.

### Privilege level

Los bits 12 y 13 son el registro `IOPL`, o Input Output Privilege Level. Representa los "niveles de privilegio" o "rings" que determinan el nivel de control que tiene el programa sobre el sistema. Si `IOPL` = 0 se habla de "Ring 0" o "Kernel mode", y si `IOPL` = 1 se habla de "Ring 3" o "User mode". En Linux, sólo el Kernel se ejecuta en Kernel mode, mientras que todos los programas de usuario se ejecutan en User mode o _userland_. Sólo el Kernel tiene control absoluto sobre el hardware.

Tratemos de alterar el nivel de privilegio modificando el registro `eflags`. En `privilege_level.asm` se pushea el registro `eflags` al stack y se mueve al registro `eax`. Se alteran los bits 12 y 13 para que sean 0, y se pushea esto al registro `eflags`. Luego, se ejecuta una instrucción privilegiada (`out`) para verificar si se cuenta con este nivel de privilegio.

Builder y ejecutar `privilege_level`. ¿Cuál fue el resultado?


TODO: docker con todo?
TODO: otras plataformas?



# Bibliografía
