#!/bin/bash

# Returns a random day within last year

set -e

RANDOM_DAYS_AGO=$((RANDOM % 365))
RANDOM_SECONDS=$((RANDOM % 86400))

RANDOM_DATE=$(date -d "-${RANDOM_DAYS_AGO} days -${RANDOM_SECONDS} seconds" "+%Y-%m-%d %H:%M:%S")

echo "${RANDOM_DATE}"
