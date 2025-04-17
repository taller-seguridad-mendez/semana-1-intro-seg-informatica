#!/bin/bash

# Receives scripts directory as argument

set -e

USERS=("alice" "pepe" "bob")

i=1
while [[ "${i}" -le "${#USERS[@]}" ]]; do
	printf 'Running test %s...\n' "${i}"
	SELECTED_USER=${USERS[$((i - 1))]}
	OUTPUT=$(bash "${1}/resumen.sh" "${1}/tests/logs/${i}.log" "${SELECTED_USER}")
	EXPECTED=$(cat "${1}/tests/expected/${i}.resumen")
	if [[ "${OUTPUT}" != "${EXPECTED}" ]]; then
		printf 'Test %s failed\n' "${i}"
		printf 'Output:\n%s\n\n' "${OUTPUT}"
		printf 'Expected:\n%s\n' "${EXPECTED}"
		exit 1
	else
		printf 'Test %s passed\n\n' "${i}"
	fi
	((i++))
done
