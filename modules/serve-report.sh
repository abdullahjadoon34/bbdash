#!/bin/bash

# -------------------------------
# serve-report.sh
# Launches local dashboard in browser
# -------------------------------

PORT=8080
REPORT_DIR="reports"
INDEX_FILE="index.html"

# Check if report exists
if [ ! -f "$REPORT_DIR/$INDEX_FILE" ]; then
  echo "❌ $INDEX_FILE not found in $REPORT_DIR. Please run a scan first."
  exit 1
fi

# Start a simple HTTP server
echo "📡 Serving reports on http://localhost:$PORT"
cd "$REPORT_DIR"

# Try Python3, then fallback to Python
if command -v python3 &>/dev/null; then
  python3 -m http.server "$PORT"
elif command -v python &>/dev/null; then
  python -m SimpleHTTPServer "$PORT"
else
  echo "❌ Python is not installed. Install Python to serve the report."
  exit 1
fi
