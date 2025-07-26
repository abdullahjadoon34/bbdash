#!/bin/bash
# Wayback URL fetcher

domain=$1
output="output/$domain/wayback/waybackurls.txt"

mkdir -p "$(dirname "$output")"
echo "[*] Getting wayback URLs for $domain..."
echo "$domain" | waybackurls > "$output"
