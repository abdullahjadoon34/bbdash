# bbdash - Bug Bounty Dashboard Toolkit

**bbdash** is an advanced automated bug bounty toolkit built for Kali Linux. It supports full recon, vulnerability scanning, OWASP Top 10 testing, origin IP detection, wayback data analysis, and report generation in Markdown + HTML formats.

### Features:
- OWASP Top 10 2023 scanning
- Wayback URLs (`waybackurls`, `gau`)
- Subdomain enumeration (`subfinder`, `amass`, `assetfinder`)
- Port scanning (`naabu`, `rustscan`)
- JS analysis (`linkfinder`, `JSParser`)
- Advanced XSS/SSRF/CSRF testing (`dalfox`, `gf`, `kxss`)
- Reporting in Markdown + HTML
- One-command setup via `./install.sh`
- Local dashboard via `serve-report.sh`

### Usage:

```bash
git clone https://github.com/yourusername/bbdash.git
cd bbdash
chmod +x *.sh modules/*/*.sh
./install.sh
./bbdash.sh
