#!/bin/bash
# Report Generator for bbdash

TARGET=$1
OUTDIR="output/$TARGET"
REPORT="$OUTDIR/report.md"
HTML_REPORT="$OUTDIR/report.html"

echo "[*] Generating Markdown Report: $REPORT"

cat <<EOF > "$REPORT"
# Bug Bounty Report for \`$TARGET\`

**Scan Date:** $(date)
**Output Directory:** \`$OUTDIR\`

---

## ✅ Recon Summary

- Subdomains found: $(wc -l < "$OUTDIR/subdomains.txt")
- Alive Hosts: $(wc -l < "$OUTDIR/alive.txt")
- Wayback URLs: $(wc -l < "$OUTDIR/wayback.txt")

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

### Arjun Parameters

\`\`\`
$(cat "$OUTDIR/arjun-params.txt" 2>/dev/null)
\`\`\`

---

### FFUF Directory Brute Force

**Output files:**  
$(ls "$OUTDIR"/ffuf-*.html 2>/dev/null | sed 's/^/- /')

---

## 📎 JS Files Collected

\`\`\`
$(cat "$OUTDIR/jsfiles.txt" 2>/dev/null)
\`\`\`

---

EOF

echo "[✓] Markdown report saved to: $REPORT"

# ─────────────────────────────────────────────
echo "[*] Converting Markdown to HTML..."

if command -v pandoc >/dev/null 2>&1; then
    pandoc "$REPORT" -o "$HTML_REPORT"
    echo "[✓] HTML report saved to: $HTML_REPORT"
else
    echo "[!] 'pandoc' not found. Skipping HTML report generation."
fi
