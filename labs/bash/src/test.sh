#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

for test in "${SCRIPT_DIR}"/tests/*.sh; do
	bash "$test" "${SCRIPT_DIR}"
done

echo "All tests passed"
