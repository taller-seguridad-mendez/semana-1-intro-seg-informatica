#!/bin/bash

# Returns a log entry

set -e

RANDOM_DIR="./tests/logs_gen/random"

DATE=$("${RANDOM_DIR}/get_date.sh")
TYPE=$("${RANDOM_DIR}/get_type.sh")
USERNAME=$("${RANDOM_DIR}/get_user.sh")
ACTION=$("${RANDOM_DIR}/get_action.sh")
DOCUMENT=$("${RANDOM_DIR}/get_file.sh")
SIZE=$("${RANDOM_DIR}/get_size.sh")
IP=$("${RANDOM_DIR}/get_ip.sh")

if [[ "${DOCUMENT}" != "" ]]; then
	printf '%s %s user=%s action=%s file=%s size=%s ip=%s\n' "${DATE}" "${TYPE}" "${USERNAME}" "${ACTION}" "${DOCUMENT}" "${SIZE}" "${IP}"
else
	printf '%s %s user=%s action=%s size=%s ip=%s\n' "${DATE}" "${TYPE}" "${USERNAME}" "${ACTION}" "${SIZE}" "${IP}"
fi
