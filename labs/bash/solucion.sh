#!/bin/bash

{ [[ -z "${1}" ]] || [[ -z "${2}" ]]; } && exit 1

LOGS=$(grep "${2}" "${1}" | grep -v "file=" | sort)

ACTIONS=$(echo "${LOGS}" | wc -l)

SIZES=$(echo "${LOGS}" | grep -o 'size=[0-9]*' | cut -d= -f2)

total_size=0
while read -r size; do
	total_size=$((total_size + size))
done <<<"${SIZES}"

FIRST_DATE=$(echo "${LOGS}" | head -n 1 | cut -d' ' -f1,2)
LAST_DATE=$(echo "${LOGS}" | tail -n 1 | cut -d' ' -f1,2)
IPS=$(echo "${LOGS}" | awk -F'ip=' '{print $2}' | sort -V)

printf 'User: %s\n' "${2}"
printf 'Actions: %s\n' "${ACTIONS}"
printf 'Total Size: %s bytes\n' "${total_size}"
printf 'First Seen: %s\n' "${FIRST_DATE}"
printf 'Last Seen: %s\n' "${LAST_DATE}"
printf 'IPs:\n'
while read -r ip; do
	echo "${ip}"
done <<<"${IPS}"
