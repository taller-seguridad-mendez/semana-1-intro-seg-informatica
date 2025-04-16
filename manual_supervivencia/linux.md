# Filesystem y comandos básicos

En la base del filesystem está `/`, o la _root_. Los principales subdirectorios son:
- `/root`: hogar del todopoderoso usuario _root_
- `/etc`: contiene archivos de configuración
- `/home`: donde están las cosas del usuario
- `/mnt`: aquí se montan otros filesystems
- `/media`: aquí suelen montarse otros dispositivos
- `/bin`: donde residen los binarios de las aplicaciones
- `/lib`: donde están las librerías compartidas

**¿Dónde estoy?**

```sh
$ pwd
/home
```

**¿Quién soy?**

```sh
$ whoami
root
```

## Navegando el filesystem

**Cambiar directorio con `cd`**

Ir a root:

```sh
$ cd /
$ pwd
/
```

Entrar a algún directorio:

```sh
$ cd /etc
$ pwd
/etc
```

Subir un nivel:

```sh
$ cd ..
$ pwd
/
```

**Listar el contenido de un directorio con `ls`**

```sh
$ ls
bin dev home ...
```

Más información:

```sh
$ ls -l
total 84
lrwxrwxrwx   1 root root     7 Mar  3  2024 bin -> usr/bin
drwxr-xr-x   3 root root  4096 Apr 12 20:48 boot
drwxr-xr-x  19 root root  3520 Apr 13 19:56 dev
...
```

Archivos ocultos:

```sh
$ ls -a
.   bin   .cache  etc ...
```

Las flags se pueden combinar:

```sh
$ ls -la
total 96
drwxr-xr-x  19 root root  4096 Apr 12 20:47 .
drwxr-xr-x  19 root root  4096 Apr 12 20:47 ..
lrwxrwxrwx   1 root root     7 Mar  3  2024 bin -> usr/bin
drwxr-xr-x   3 root root  4096 Apr 12 20:48 boot
...
```

## Obtener ayuda y manpages

Casi todos los comandos, aplicaciones o utilidades tienen una sección de ayuda. En general, se accede de alguna de las siguientes formas:

```sh
$ ls --help
```

```sh
$ nmap -h
```

Estas son convenciones, por lo que puede variar entre aplicaciones.

Además, el sistema cuenta con manuales de referencia para casi todo lo que se nos pueda ocurrir. Simplemente:

```sh
$ man man
```

En este caso, buscamos la entrada del manual para el propio manual. El manual cuenta con varias secciones, numeradas de 1 a 9. Se puede buscar su significado en la entrada del manual para `man`. Cuando se deba desambiguar una entrada del manual, se puede especificar en qué sección se desea buscar. Por ejemplo, `exit` tiene entradas en las secciones 2 y 3, entonces se puede especificar la búsqueda mediante:

```sh
$ man 2 exit
```

# Encontrar cosas

**Encontrar con `locate`**

Busca todas las ocurrencias de la palabra en el filesystem:

```sh
$ locate vim
/etc/vim
/etc/vim/vimrc
/etc/vim/vimrc.tiny
...
```

**Encontrar binarios con `whereis` y `which`**

Si buscamos un binario en particular:

```sh
$ whereis vi
vi: /usr/bin/vi /usr/share/man/man1/vi.1.gz
```

Se puede ser todavía más específico y buscar únicamente en la variable `PATH`, mediante:

```sh
$ which vi
/usr/bin/vi
```

**Búsquedas más poderosas con `find`**

Es las más flexible y poderosa de las utilidades. Permite comenzar la búsqueda en cualquier directorio y puede recibir múltiples parámetros.

**Filtrar con `grep`**

Filtra resultados según una keyword. Normalmente, toma la salida de otro comando, por lo que lo usamos con _pipe_:

```sh
$ ps aux | grep root
```

## Modificar archivos y directorios

**Crear un archivo con `touch`**

```sh
$ touch archivo.txt
```

**Crear un directorio con `mkdir`**

```sh
$ mkdir directorio
```

**Copiar un archivo con `cp`**

```sh
$ cp archivo.txt /root/directorio/copia_archivo.txt
```

**Mover un archivo con `mv`**

```sh
$ mv archivo.txt /root/directorio/copia_archivo.txt
```

**Renombrar un archivo**

No existe una utilidad específica, se usa `mv` de la siguiente forma:

```sh
$ mv archivo.txt renombrado.txt
$ ls
renombrado.txt
```

**Eliminar un archivo**

```sh
$ rm archivo.txt
```

**Eliminar un directorio**

```sh
$ rmdir directorio
```

Esto fallará si no está vacío. Si se desea eliminar un directorio y todo su contenido, incluyendo todos los subdirectorios, se forma recursiva usar:

```sh
$ rm -r directorio
```

Ojo!

**Concatenación con `cat`** [TODO]
