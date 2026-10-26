
#!/bin/bash

REPORT="process_report.txt"

scan_processes() {
    local total=0
    local flagged=0
    local normal=0

    echo "Suspicious Process Hunter Report" > "$REPORT"
    echo "Date: $(date)" >> "$REPORT"
    echo "----------------------------------------" >> "$REPORT"

    echo ""
    echo "[+] Scanning processes..."
    echo ""

    printf "%-8s %-12s %-20s %-10s\n" \
        "PID" "USER" "COMMAND" "STATUS"

    while read -r pid user comm args; do
        ((total++))
        status="NORMAL"

        case "$args" in
            *"/tmp/"*|*"/dev/shm/"*)
                status="CHECK"
                ((flagged++))
                echo "PID=$pid USER=$user COMMAND=$comm DETAILS=$args" \
                    >> "$REPORT"
                ;;
            *)
                ((normal++))
                ;;
        esac

        printf "%-8s %-12s %-20s %-10s\n" \
            "$pid" "$user" "$comm" "$status"

    done < <(ps -eo pid,user,comm,args --no-headers)

    {
        echo ""
        echo "SCAN SUMMARY"
        echo "Total processes: $total"
        echo "Normal processes: $normal"
        echo "Flagged processes: $flagged"
    } >> "$REPORT"

    echo ""
    echo "========== SCAN SUMMARY =========="
    echo "Total processes  : $total"
    echo "Normal processes : $normal"
    echo "Flagged processes: $flagged"
    echo "=================================="
    echo "[+] Report saved: $REPORT"
}

while true; do
    clear
    echo "======================================"
    echo "     SUSPICIOUS PROCESS HUNTER"
    echo "======================================"
    echo "1. Scan Processes"
    echo "2. View Report"
    echo "3. Exit"
    echo "======================================"
    read -rp "Enter your choice: " choice

    case "$choice" in
        1)
            scan_processes
            read -rp "Press Enter to continue..."
            ;;
        2)
            if [ -f "$REPORT" ]; then
                cat "$REPORT"
            else
                echo "No report found. Run a scan first."
            fi
            read -rp "Press Enter to continue..."
            ;;
        3)
            echo "Exiting Suspicious Process Hunter..."
            exit 0
            ;;
        *)
            echo "Invalid choice!"
            sleep 1
            ;;
    esac
done
