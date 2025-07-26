#!/bin/bash
# Active Scan Script for bbdash

TARGET=$1
OUTDIR="output/$TARGET"
NUCLEI_TEMPLATES="$HOME/nuclei-templates"

echo "[*] Starting active scans for: $TARGET"
echo "[*] Using output folder: $OUTDIR"

# ─────────────────────────────────────────────
echo "[1] Nuclei Scan (OWASP, CVEs, Exposures)..."
nuclei -l "$OUTDIR/scan_targets.txt" -t "$NUCLEI_TEMPLATES" \
  -severity low,medium,high,critical -o "$OUTDIR/nuclei-results.txt"

echo "[✓] Nuclei results saved to: $OUTDIR/nuclei-results.txt"

# ─────────────────────────────────────────────
echo "[2] Dalfox XSS Param Scan..."
dalfox file "$OUTDIR/scan_params.txt" --custom-header "X-Test: scan" --mining-dict wordlists/params.txt \
  --output "$OUTDIR/dalfox-results.txt" --format plain

echo "[✓] Dalfox XSS results saved to: $OUTDIR/dalfox-results.txt"

# ─────────────────────────────────────────────
echo "[3] KXSS (JS-based reflected param finder)..."
cat "$OUTDIR/jsfiles.txt" | kxss > "$OUTDIR/kxss-results.txt"
echo "[✓] KXSS results saved to: $OUTDIR/kxss-results.txt"

# ─────────────────────────────────────────────
echo "[4] SSRF, CORS, Open Redirect via nuclei templates..."
nuclei -l "$OUTDIR/scan_targets.txt" \
  -t "$NUCLEI_TEMPLATES"/misconfiguration/ -o "$OUTDIR/nuclei-misconfig.txt"

echo "[✓] Misconfig scan complete: $OUTDIR/nuclei-misconfig.txt"

# ─────────────────────────────────────────────
echo "[5] Arjun (Parameter Discovery)..."
arjun -i "$OUTDIR/scan_targets.txt" -oT "$OUTDIR/arjun-params.txt"
echo "[✓] Arjun param results: $OUTDIR/arjun-params.txt"

# ─────────────────────────────────────────────
echo "[6] FFUF Directory Brute-Force (Common paths)..."
while read -r url; do
  ffuf -w wordlists/common-dirs.txt -u "$url/FUZZ" -mc 200 -t 50 \
    -of html -o "$OUTDIR/ffuf-$(echo $url | cut -d/ -f3).html"
done < "$OUTDIR/scan_targets.txt"

echo "[✓] FFUF scans complete (HTML files in $OUTDIR)"

# ─────────────────────────────────────────────
echo "[✓] Scanning complete for: $TARGET"
