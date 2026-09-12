#!/bin/bash

echo "=================================="
echo "     SERVER PERFORMANCE STATS     "
echo "=================================="

# Total CPU Usage
echo ""
echo "--- CPU Usage ---"
top -bn1 | grep "Cpu(s)" | awk -F'[, ]' '{for(i=1;i<=NF;i++) if($i ~ /id/) printf "Total CPU Usage: %.2f%%\n", 100 - $(i-1)}'

# Total Memory Usage
echo ""
echo "--- Memory Usage ---"
free -m | awk 'NR==2{printf "Free: %sMB / Used: %sMB (Used: %.2f%%)\n", $4, $3, $3*100/$2}'

# Total Disk Usage
echo ""
echo "--- Disk Usage ---"
df -h / | awk 'NR==2{printf "Free: %s / Used: %s (Used: %s)\n", $4, $3, $5}'

# Top 5 Processes by CPU Usage
echo ""
echo "--- Top 5 Processes by CPU Usage ---"
ps aux --sort=-%cpu | head -n 6 | awk 'NR==1{printf "%-10s %-10s %-10s %s\n", "PID", "USER", "%CPU", "COMMAND"} NR>1{printf "%-10s %-10s %-10s %s\n", $2, $1, $3, $11}'

# Top 5 Processes by Memory Usage
echo ""
echo "--- Top 5 Processes by Memory Usage ---"
ps aux --sort=-pmem | head -n 6 | awk 'NR==1{printf "%-10s %-10s %-10s %s\n", "PID", "USER", "%MEM", "COMMAND"} NR>1{printf "%-10s %-10s %-10s %s\n", $2, $1, $4, $11}'

# OS Version
echo ""
echo "--- OS Version ---"
lsb_release -d | awk -F'\t' '{print $2}'

# System Uptime
echo ""
echo "--- System Uptime ---"
uptime -p | sed 's/^up //'

# Load Average
echo ""
echo "--- Load Average ---"
awk '{printf "1 min: %s | 5 min: %s | 15 min: %s\n", $1, $2, $3}' /proc/loadavg

# Logged-in Users
echo ""
echo "--- Logged-in Users ---"
who | awk '{print $1}' | sort -u | grep . || whoami

