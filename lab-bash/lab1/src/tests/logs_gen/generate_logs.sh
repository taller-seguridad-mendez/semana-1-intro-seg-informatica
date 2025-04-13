#!/bin/bash

# Returns logs.

LOG_DIR=$(mktemp -d)
LOG_FILE="${LOG_DIR}/logs"

mkdir -p "${LOG_DIR}"

AMOUNT_OF_LOGS=$(((RANDOM % 100) + 100))

>"${LOG_FILE}"

i=0
while [[ "${AMOUNT_OF_LOGS}" -gt "${i}" ]]; do
	"./tests/logs_gen/generate_log.sh" >>"${LOG_FILE}"
	((i++))
done

cat "${LOG_FILE}"
