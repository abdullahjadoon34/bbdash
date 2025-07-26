#!/bin/bash
# Enhanced Report Generator for bbdash

TARGET=$1
OUTDIR="output/$TARGET"
REPORT="$OUTDIR/report.md"
HTML_REPORT="$OUTDIR/report.html"

mkdir -p "$OUTDIR"

echo "[*] Generating Markdown Report: $REPORT"

cat <<EOF > "$REPORT"
# 🛡️ Bug Bounty Report for \`$TARGET\`

**Scan Date:** $(date)  
**Output Directory:** \`$OUTDIR\`

---

## ✅ Recon Summary

- Subdomains found: \`$(wc -l < "$OUTDIR/subdomains.txt" 2>/dev/null)\`
- Alive Hosts: \`$(wc -l < "$OUTDIR/alive.txt" 2>/dev/null)\`
- Wayback URLs: \`$(wc -l < "$OUTDIR/wayback.txt" 2>/dev/null)\`

---

## 🔍 Vulnerability Scan Summary

### Nuclei (All Severity)
\`\`\`
$(cat "$OUTDIR/nuclei-results.txt" 2>/dev/null)
\`\`\`

---

### Nuclei (Misconfigurations)
\`\`\`
$(cat "$OUTDIR/nuclei-misconfig.txt" 2>/dev/null)
\`\`\`

---

### Dalfox (XSS Detection)
\`\`\`
$(cat "$OUTDIR/dalfox-results.txt" 2>/dev/null)
\`\`\`

---

### KXSS Reflected Params
\`\`\`
$(cat "$OUTDIR/kxss-results.txt" 2>/dev/null)
\`\`\`

---

### GF Patterns (XSS, SSRF, IDOR, etc.)
\`\`\`
$(cat "$OUTDIR/gf-patterns.txt" 2>/dev/null)
\`\`\`

---

### SSRF Test
\`\`\`
$(cat "$OUTDIR/ssrf-results.txt" 2>/dev/null)
\`\`\`

---

### CORS Test
\`\`\`
$(cat "$OUTDIR/cors-results.txt" 2>/dev/null)
\`\`\`

---

### CSRF Test
\`\`\`
$(cat "$OUTDIR/csrf-results.txt" 2>/dev/null)
\`\`\`

---

### Open Redirect Test
\`\`\`
$(cat "$OUTDIR/redirect-results.txt" 2>/dev/null)
\`\`\`

---

### Arjun Parameters
\`\`\`
$(cat "$OUTDIR/arjun-params.txt" 2>/dev/null)
\`\`\`

---

### FFUF Directory Bruteforce
**FFUF Output Files:**  
$(ls "$OUTDIR"/ffuf-*.html 2>/dev/null | sed 's/^/- /')

---

## 📎 JavaScript Files Collected
\`\`\`
$(cat "$OUTDIR/jsfiles.txt" 2>/dev/null)
\`\`\`

---

EOF

echo "[✓] Markdown report saved to: $REPORT"

# ─────────────────────────────
echo "[*] Converting Markdown to HTML..."

if command -v pandoc >/dev/null 2>&1; then
    pandoc "$REPORT" -o "$HTML_REPORT"
    echo "[✓] HTML report saved to: $HTML_REPORT"
else
    echo "[!] 'pandoc' not found. Skipping HTML report generation."
fi
