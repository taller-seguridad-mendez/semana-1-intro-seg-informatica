# Bash: Resumen de logs

El script tendrá como parámetros la dirección del archivo que contiene logs, y
un nombre de usuario como segundo parámetro.

## Logs

El archivo de logs tendrá el siguiente formato:

```log
[2025-04-12 15:32:10] INFO  user=alice action=upload size=1024 ip=196.168.0.28
[2025-04-12 15:35:01] ERROR user=bob action=delete size=0 ip=200.141.23.1
[2025-04-12 15:35:01] ERROR user=bob size=0 ip=10.4.3.2
```

Los logs no están ordenados de ninguna manera. Notar que algunos logs no tienen
el campo `file`.

## Comandos

Los comandos recomendados para este script son:

- `echo`
- `grep` (ver flags `-v` y `-o`)
- `awk`
- `sort`
- `cut`
- `head` y `tail`
- `wc`

Usar `man <comando>` para obtener la información necesaria.

Además, repasar los conceptos de loops, condicionales, arrays, y manejo de
archivos.

## Consigna

Se necesita obtener un resumen de un archivo de logs de actividades para un
usuario en particular. Este resumen debe tener la fecha de la primer y última
actividad del usuario, la cantidad de acciones de ese usuario, y la cantidad
total de bytes involucrados.

Para lograr esto, se requiere un script `resumen.sh` que reciba la dirección
del archivo de logs, y el nombre del usuario. En caso de no recibirlo, se debe
salir del script con exit code 1.

```sh
./resumen.sh <logs> <usuario>
```

El script debe devolver por `stdout` un resumen de este estilo:

```log
User: alice
Actions: 3
Total Size: 2048 bytes
First Seen: 2025-04-12 15:32:10
Last Seen: 2025-04-12 17:44:59
IPs:
1.239.40.3
43.170.3.255
43.171.3.255
```

Debe imprimir todas las IPs de cada acción en orden descendiente (tener en
cuenta que se debe ordenar numéricamente). No se debe contar los logs con el
campo de `file`.

El script se considera aprobado cuando pasa todos los tests necesarios. Se debe
crear un archivo `resumen.sh` en `src/`. No está permitido modificar otro
archivo que no sea `resumen.sh`, ni crear archivos adicionales. Tampoco está
permitido modificar el `Dockerfile`.

## Testing

**Dependencias:** `docker`

Para testear una solución, se puede correr el siguiente comando:

```sh
docker build -t lab-bash-1 . && docker run --rm -it lab-bash-1
```
