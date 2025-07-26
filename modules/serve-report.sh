#!/bin/bash

# serve-report.sh - Serve HTML bug bounty report via local HTTP

PORT=8080

# Allow target name as argument
TARGET="$1"
OUTPUT_DIR="output"

# If no target passed, ask user to select one
if [ -z "$TARGET" ]; then
  echo "📂 Available reports:"
  ls "$OUTPUT_DIR"
  echo -n "📝 Enter target name to serve report: "
  read TARGET
fi

REPORT_HTML="$OUTPUT_DIR/$TARGET/report.html"

# Check if report exists
if [ ! -f "$REPORT_HTML" ]; then
  echo "❌ Report not found: $REPORT_HTML"
  echo "👉 Please run ./report.sh $TARGET first."
  exit 1
fi

cd "$OUTPUT_DIR/$TARGET"

# Serve the report
echo "📡 Serving report for '$TARGET' at: http://localhost:$PORT/report.html"
echo "🌐 Opening in browser..."
xdg-open "http://localhost:$PORT/report.html" &>/dev/null || open "http://localhost:$PORT/report.html" &>/dev/null

# Start local server
if command -v python3 &>/dev/null; then
  python3 -m http.server "$PORT"
elif command -v python &>/dev/null; then
  python -m SimpleHTTPServer "$PORT"
else
  echo "❌ Python is not installed. Please install Python to use this feature."
  exit 1
fi
