#!/bin/bash

# gau.sh - Fetch historical URLs using gau
# Usage: ./modules/tools/gau.sh <domain>

DOMAIN=$1
OUTPUT="results/$DOMAIN/recon/wayback/gau.txt"

if [ -z "$DOMAIN" ]; then
    echo "❌ Usage: $0 <domain>"
    exit 1
fi

mkdir -p "$(dirname "$OUTPUT")"

echo "🕓 Gathering historical URLs from gau for $DOMAIN..."
gau "$DOMAIN" | sort -u > "$OUTPUT"

echo "✅ URLs saved to: $OUTPUT"
