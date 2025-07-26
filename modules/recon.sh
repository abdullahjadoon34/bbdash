#!/bin/bash
# Recon Script for bbdash

TARGET=$1
OUTDIR="output/$TARGET"
mkdir -p "$OUTDIR"

echo "[*] Recon started for: $TARGET"
echo "[*] Output Directory: $OUTDIR"

# ─────────────────────────────────────────────
echo "[1] Subdomain Enumeration..."
subfinder -d "$TARGET" -silent > "$OUTDIR/subdomains.txt"
assetfinder --subs-only "$TARGET" >> "$OUTDIR/subdomains.txt"
sort -u "$OUTDIR/subdomains.txt" -o "$OUTDIR/subdomains.txt"
echo "[✓] Found $(wc -l < "$OUTDIR/subdomains.txt") subdomains."

# ─────────────────────────────────────────────
echo "[2] IP Resolution..."
httpx -l "$OUTDIR/subdomains.txt" -silent -ip > "$OUTDIR/resolved.txt"
cut -d ' ' -f1 "$OUTDIR/resolved.txt" > "$OUTDIR/live_hosts.txt"
echo "[✓] Live hosts saved to: $OUTDIR/live_hosts.txt"

# ─────────────────────────────────────────────
echo "[3] Wayback + Gau URLs..."
gau "$TARGET" >> "$OUTDIR/waybackurls.txt"
waybackurls "$TARGET" >> "$OUTDIR/waybackurls.txt"
sort -u "$OUTDIR/waybackurls.txt" -o "$OUTDIR/waybackurls.txt"
echo "[✓] Total URLs collected: $(wc -l < "$OUTDIR/waybackurls.txt")"

# ─────────────────────────────────────────────
echo "[4] JavaScript File URLs..."
grep -E "\.js($|\?)" "$OUTDIR/waybackurls.txt" | grep "$TARGET" > "$OUTDIR/jsfiles.txt"
echo "[✓] JS files extracted: $(wc -l < "$OUTDIR/jsfiles.txt")"

# ─────────────────────────────────────────────
echo "[5] Params from Wayback URLs..."
cat "$OUTDIR/waybackurls.txt" | unfurl --unique keys > "$OUTDIR/params.txt"
echo "[✓] Params extracted: $(wc -l < "$OUTDIR/params.txt")"

# ─────────────────────────────────────────────
echo "[6] Preparing for scan..."
cp "$OUTDIR/live_hosts.txt" "$OUTDIR/scan_targets.txt"
cp "$OUTDIR/params.txt" "$OUTDIR/scan_params.txt"
cp "$OUTDIR/jsfiles.txt" "$OUTDIR/scan_js.txt"

echo "[✓] Recon complete. All files stored in $OUTDIR"
