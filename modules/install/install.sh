#!/bin/bash

# -------------------------------
# install.sh
# Installs all required bug bounty tools
# -------------------------------

echo "🔧 Installing required tools for bbdash..."

# Ensure Go is installed
if ! command -v go &>/dev/null; then
    echo "❌ Go is not installed. Please install Golang first (https://go.dev/doc/install)."
    exit 1
fi

export GOBIN=$HOME/go/bin
export PATH=$PATH:$GOBIN

# Create bin directory
mkdir -p "$GOBIN"

# Install tools
echo "📦 Installing subfinder..."
go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest

echo "📦 Installing httpx..."
go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest

echo "📦 Installing nuclei..."
go install -v github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest

echo "📦 Installing gau..."
go install -v github.com/lc/gau/v2/cmd/gau@latest

echo "📦 Installing dalfox..."
go install -v github.com/hahwul/dalfox/v2@latest

echo "📦 Installing ffuf..."
go install -v github.com/ffuf/ffuf@latest

echo "📦 Installing amass..."
go install -v github.com/owasp-amass/amass/v4/...@master

echo "📦 Installing waybackurls..."
go install -v github.com/tomnomnom/waybackurls@latest

echo "📦 Installing qsreplace..."
go install -v github.com/tomnomnom/qsreplace@latest

echo "📦 Installing gf + patterns..."
go install -v github.com/tomnomnom/gf@latest
mkdir -p ~/.gf
git clone https://github.com/1ndianl33t/Gf-Patterns ~/.gf-patterns
cp ~/.gf-patterns/*.json ~/.gf/

echo "📦 Installing naabu..."
go install -v github.com/projectdiscovery/naabu/v2/cmd/naabu@latest

echo "📦 Installing kxss..."
go install -v github.com/tomnomnom/hacks/kxss@latest

# Python tools
echo "📦 Installing Python-based tools (linkfinder, JSParser)..."
pipx install linkfinder || pip install linkfinder
git clone https://github.com/nahamsec/JSParser.git ~/tools/JSParser

echo "✅ All tools installed in: $GOBIN"
echo "⚙️ Add this to your ~/.bashrc or ~/.zshrc:"
echo 'export PATH=$PATH:$HOME/go/bin'

