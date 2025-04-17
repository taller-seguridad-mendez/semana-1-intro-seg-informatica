#!/bin/bash

# Receives scripts directory as argument

set -e

echo 'Running param test...'

bash "${1}/resumen.sh" && exit 1

printf 'Param test passed.\n\n'
