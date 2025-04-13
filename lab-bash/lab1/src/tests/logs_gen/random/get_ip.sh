#!/bin/bash

# Generates random IPv4 values

set -e

echo "$((RANDOM % 256)).$((RANDOM % 256)).$((RANDOM % 256)).$((RANDOM % 256))"
