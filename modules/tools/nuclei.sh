#!/bin/bash
# Nuclei Scanner

input=$1
output="output/$domain/vulns/nuclei.txt"

mkdir -p "$(dirname "$output")"
echo "[*] Running nuclei on $input..."
nuclei -l "$input" -severity low,medium,high,critical -c 50 -o "$output"