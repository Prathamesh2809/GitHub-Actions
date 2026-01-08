#!/bin/bash
set -e  # exit on error

LOG_FILE="system_info.log"
BACKUP_DIR="backup"

echo "Collecting system info..."
{
  echo "Date: $(date)"
  echo "User: $(whoami)"
  echo "Uptime: $(uptime -p)"
  echo "Disk usage:"
  df -h
} > "$LOG_FILE"

mkdir -p "$BACKUP_DIR"

echo "=== System Health Report ==="

# 1. Date and host info
echo "Date: $(date)"
echo "Host: $(hostname)"

# 2. Uptime
echo "Uptime: $(uptime -p)"

# 3. CPU load
echo "CPU Load: $(uptime | awk -F'load average:' '{ print $2 }')"

# 4. Memory usage
echo "Memory usage:"
free -h

# 5. Disk usage
echo "Disk usage:"
df -h --total | grep total

# 6. Top 5 processes
echo "Top 5 processes by memory:"
ps -eo pid,comm,%mem --sort=-%mem | head -n 6

echo "=== End of Report ==="
