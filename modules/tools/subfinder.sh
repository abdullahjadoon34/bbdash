#!/bin/bash

# Usage: ./subfinder.sh example.com

domain=$1
output_dir="output/$domain"
mkdir -p "$output_dir"

echo "[+] Running Subfinder for $domain..."
subfinder -d "$domain" -silent -o "$output_dir/subdomains.txt"

echo "[+] Subdomains saved to $output_dir/subdomains.txt"

