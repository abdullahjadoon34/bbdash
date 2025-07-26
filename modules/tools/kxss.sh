#!/bin/bash
# KXSS - Finds parameters that could be vulnerable to XSS

input=$1
output="output/$domain/xss/kxss.txt"

mkdir -p "$(dirname "$output")"
echo "[*] Running KXSS on $input..."

cat "$input" | kxss > "$output"
