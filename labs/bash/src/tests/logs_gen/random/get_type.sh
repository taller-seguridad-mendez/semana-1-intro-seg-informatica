#!/bin/bash

# Returns a random type of log

set -e

USERS=("INFO" "WARN" "DEBUG" "ERROR")
random_index=$((RANDOM % ${#USERS[@]}))
echo "${USERS[${random_index}]}"
