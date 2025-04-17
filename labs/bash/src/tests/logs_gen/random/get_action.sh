#!/bin/bash

# Returns a random action, or no action

set -e

ACTIONS=("upload" "delete" "download")
random_index=$((RANDOM % ${#ACTIONS[@]}))
echo "${ACTIONS[${random_index}]}"
