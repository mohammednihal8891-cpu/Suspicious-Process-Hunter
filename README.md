
# 🔍 Suspicious Process Hunter

A Bash-based cybersecurity tool for monitoring Linux processes and flagging processes running from selected writable locations.

## Features

- Lists running Linux processes
- Flags process command lines containing `/tmp/` or `/dev/shm/`
- Displays total, normal, and flagged process counts
- Generates a text-based scan report
- Provides a simple menu-driven interface

## Technologies Used

- Kali Linux
- Bash Scripting
- Linux commands (`ps`, `date`)

## How to Run

Clone or download this project, then open its folder in the terminal.

```bash
chmod +x hunter.sh
./hunter.sh
```

## Menu Options

1. Scan Processes
2. View Report
3. Exit

## Important Note

This is a basic learning and auditing tool. A process flagged by this script is not necessarily malicious. It only checks for selected path patterns and does not provide complete malware detection.

## Author

Mohammed Nihal

Cybersecurity Student
