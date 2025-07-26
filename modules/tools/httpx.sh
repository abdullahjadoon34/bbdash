#!/bin/bash

# Usage: ./httpx.sh example.com

domain=$1
input_file="output/$domain/subdomains.txt"
output_dir="output/$domain"
mkdir -p "$output_dir"

if [[ ! -f "$input_file" ]]; then
    echo "[!] Subdomains file not found: $input_file"
    exit 1
fi

echo "[+] Checking for live hosts using httpx..."
cat "$input_file" | httpx -silent -status-code -title -tech-detect -o "$output_dir/live.txt"

echo "[+] Live hosts saved to $output_dir/live.txt"
