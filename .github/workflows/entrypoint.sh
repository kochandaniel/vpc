#!/bin/sh
set -eax
# Add two numeric value
black --version
black --line-length $1 --check $2