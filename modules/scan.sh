#!/bin/bash
# Enhanced Active Scan Script for bbdash

TARGET=$1
OUTDIR="output/$TARGET"
NUCLEI_TEMPLATES="$HOME/nuclei-templates"

mkdir -p "$OUTDIR"

echo "[*] Starting active scans for: $TARGET"
echo "[*] Output directory: $OUTDIR"

# Check file existence
if [[ ! -f "$OUTDIR/scan_targets.txt" ]]; then
  echo "[!] Missing scan_targets.txt in $OUTDIR"
  exit 1
fi

if [[ ! -f "$OUTDIR/scan_params.txt" ]]; then
  echo "[!] Missing scan_params.txt in $OUTDIR"
  touch "$OUTDIR/scan_params.txt"
fi

# ────────────── NUCLEI (General + OWASP Templates) ──────────────
echo "[1] Nuclei: OWASP/CVE/Exposures"
nuclei -l "$OUTDIR/scan_targets.txt" -t "$NUCLEI_TEMPLATES" \
  -severity low,medium,high,critical \
  -o "$OUTDIR/nuclei-results.txt"

# ────────────── Dalfox XSS Scan ──────────────
echo "[2] Dalfox XSS Fuzzing"
dalfox file "$OUTDIR/scan_params.txt" --custom-header "X-Test: scan" \
  --mining-dict wordlists/params.txt \
  --output "$OUTDIR/dalfox-results.txt" --format plain

# ────────────── KXSS (JS Param Reflection) ──────────────
echo "[3] KXSS Analysis"
if [[ -f "$OUTDIR/jsfiles.txt" ]]; then
  cat "$OUTDIR/jsfiles.txt" | kxss > "$OUTDIR/kxss-results.txt"
else
  echo "[!] jsfiles.txt not found, skipping KXSS"
fi

# ────────────── Misconfiguration Templates (CORS, Redirects) ──────────────
echo "[4] Nuclei: Misconfig (CORS, SSRF, Open Redirect)"
nuclei -l "$OUTDIR/scan_targets.txt" -t "$NUCLEI_TEMPLATES/misconfiguration/" \
  -o "$OUTDIR/nuclei-misconfig.txt"

# ────────────── Arjun (Hidden Parameter Discovery) ──────────────
echo "[5] Arjun Param Discovery"
arjun -i "$OUTDIR/scan_targets.txt" -oT "$OUTDIR/arjun-params.txt"

# ────────────── FFUF Directory Brute-Force ──────────────
echo "[6] FFUF Directory Brute-force"
while read -r url; do
  ffuf -w wordlists/common-dirs.txt -u "$url/FUZZ" -mc 200 -t 50 \
    -of html -o "$OUTDIR/ffuf-$(echo $url | cut -d/ -f3).html"
done < "$OUTDIR/scan_targets.txt"

# ────────────── Summary ──────────────
echo "[✓] All scans completed for: $TARGET"
echo "[✓] Results saved in: $OUTDIR"
