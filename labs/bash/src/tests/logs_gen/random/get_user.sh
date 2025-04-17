#!/bin/bash

# Returns a random user

set -e

USERS=("alice" "bob" "pepe" "juan")
random_index=$((RANDOM % ${#USERS[@]}))
echo "${USERS[${random_index}]}"
