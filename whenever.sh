#!/bin/sh

# Inspired by: https://unix.stackexchange.com/a/140681

set -e -u

DIRECTORY="$1"; shift

eval "$@"

echo -n "\n\nStart watching $DIRECTORY..."

inotifywait -q --format '%w%f' -m -r -e close_write $DIRECTORY | while read file; do
    echo "Changed: ${file}"
    eval "$@"
    echo "Done!"
done
