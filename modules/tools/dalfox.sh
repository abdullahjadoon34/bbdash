#!/bin/bash
# Dalfox - XSS Scanner

input=$1
output="output/$domain/vulns/dalfox.txt"

mkdir -p "$(dirname "$output")"
echo "[*] Running Dalfox on $input..."

cat "$input" | dalfox pipe --skip-bav -o "$output"
