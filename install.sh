#!/bin/bash
# Bug Bounty Dashboard Tool Installer

TOOLS_DIR="$HOME/go/bin"
mkdir -p "$TOOLS_DIR"
export PATH="$PATH:$TOOLS_DIR"

echo "[*] Installing dependencies..."

sudo apt update -y
sudo apt install -y golang git python3-pip curl jq chromium-driver

echo "[*] Installing Go-based tools..."

go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
go install -v github.com/tomnomnom/assetfinder@latest
go install -v github.com/tomnomnom/waybackurls@latest
go install -v github.com/tomnomnom/gf@latest
go install -v github.com/tomnomnom/httprobe@latest
go install -v github.com/tomnomnom/unfurl@latest
go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest
go install -v github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest
go install -v github.com/lc/gau/v2/cmd/gau@latest
go install -v github.com/projectdiscovery/naabu/v2/cmd/naabu@latest
go install -v github.com/hahwul/dalfox/v2@latest
go install -v github.com/Emoe/kxss@latest

echo "[*] Installing Python tools..."

pip3 install uro
pip3 install arjun

echo "[*] Installing JS analyzers..."

git clone https://github.com/GerbenJavado/LinkFinder modules/tools/LinkFinder 2>/dev/null || echo "[*] LinkFinder exists"
cd modules/tools/LinkFinder && pip3 install -r requirements.txt && cd -

git clone https://github.com/0x240x23elu/JSScanner modules/tools/JSScanner 2>/dev/null || echo "[*] JSScanner exists"

echo "[+] All tools installed to: $TOOLS_DIR"
echo "[✓] Installation complete."
