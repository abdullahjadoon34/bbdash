#!/bin/bash

# nuclei.sh - Vulnerability scanning using Nuclei
# Usage: ./modules/tools/nuclei.sh <domain>

DOMAIN=$1
INPUT="results/$DOMAIN/recon/httprobe/live.txt"
OUTPUT="results/$DOMAIN/scans/nuclei-results.txt"

if [ -z "$DOMAIN" ]; then
    echo "❌ Usage: $0 <domain>"
    exit 1
fi

if [ ! -f "$INPUT" ]; then
    echo "❌ Live hosts not found at $INPUT"
    exit 1
fi

mkdir -p "$(dirname "$OUTPUT")"

echo "🚨 Running Nuclei scan on live hosts..."
nuclei -l "$INPUT" -o "$OUTPUT" -silent -severity low,medium,high,critical

echo "✅ Nuclei report saved to: $OUTPUT"
