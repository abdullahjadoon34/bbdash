#!/bin/bash
# Bug Bounty Dashboard (bbdash) – Main launcher script

# Load configs if available
CONFIG_FILE="./config/bbdash.conf"
[[ -f "$CONFIG_FILE" ]] && source "$CONFIG_FILE"

# Colors
RED=$(tput setaf 1)
GRN=$(tput setaf 2)
YLW=$(tput setaf 3)
BLU=$(tput setaf 4)
RST=$(tput sgr0)

# Main Menu
main_menu() {
    clear
    echo "${BLU}╔══════════════════════════════╗"
    echo "║      🐞 BBDASH MAIN MENU      ║"
    echo "╚══════════════════════════════╝${RST}"
    echo ""
    echo "[1] Recon (Subdomains, Wayback, IPs)"
    echo "[2] Vulnerability Scanning"
    echo "[3] Generate Report"
    echo "[4] Serve Report (local web)"
    echo "[5] Install/Update Tools"
    echo "[0] Exit"
    echo ""
    read -p "Select: " opt

    case $opt in
        1) bash modules/recon.sh ;;
        2) bash modules/scan.sh ;;
        3) bash modules/report.sh ;;
        4) bash modules/serve-report.sh ;;
        5) bash install.sh ;;
        0) echo "${GRN}Exiting.${RST}"; exit 0 ;;
        *) echo "${RED}Invalid option.${RST}"; sleep 1 ;;
    esac
    main_menu
}

main_menu
