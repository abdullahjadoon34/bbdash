#!/bin/bash
# QSReplace - Replace query strings in URLs with payloads

input=$1
payload="INJECTXSS"
output="output/$domain/xss/qsreplace.txt"

mkdir -p "$(dirname "$output")"

echo "[*] Replacing parameters in URLs with '$payload'..."

cat "$input" | qsreplace "$payload" > "$output"
