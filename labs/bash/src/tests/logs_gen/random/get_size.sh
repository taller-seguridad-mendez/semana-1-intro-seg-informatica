#!/bin/bash

# Returns a random possible size value

set -e

MAX_ROOT=16

SIZE=$((2 ** (RANDOM % MAX_ROOT)))

printf '%sbytes' "${SIZE}"
