#!/bin/bash
# GF Patterns Extractor (like xss, sqli, lfi)

input=$1
output_dir="output/$domain/params"

mkdir -p "$output_dir"

echo "[*] Running gf patterns..."

for pattern in xss sqli lfi redirect rce ssrf; do
    cat "$input" | gf $pattern > "$output_dir/$pattern.txt"
done
