#!/bin/bash
# ParamSpider - Find hidden parameters

domain=$1
output="output/$domain/params/paramspider.txt"

mkdir -p "$(dirname "$output")"
echo "[*] Running ParamSpider on $domain..."

python3 ~/tools/ParamSpider/paramspider.py -d "$domain" -o "$output"
