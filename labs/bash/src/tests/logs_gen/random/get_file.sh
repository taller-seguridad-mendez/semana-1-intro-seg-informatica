#!/bin/bash

# Return a document

AMOUNT_OF_DOCUMENTS=10

DOCUMENT_NUMBER=$((RANDOM % AMOUNT_OF_DOCUMENTS))

RNG=$((RANDOM % 10))

if [[ "${RNG}" -eq 1 ]]; then
	echo "document${DOCUMENT_NUMBER}"
else
	echo ""
fi
