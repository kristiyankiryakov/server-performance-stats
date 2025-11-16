#!/bin/bash

echo "=== SERVER STATS ==="
echo

echo "CPU USAGE:"
grep '^cpu ' /proc/stat | awk '{printf "  %.1f%%\n", 100*($2+$3+$4+$6+$7+$8+$9+$10+$11)/($2+$3+$4+$5+$6+$7+$8+$9+$10+$11)}'
echo

echo "MEMORY USAGE:"
LC_NUMERIC=C awk '/MemTotal:/{t=$2}/MemAvailable:/{a=$2}END{used=t-a; printf "  %.1f%% used (%.2f/%.2f GB)\n", 100*used/t, used/1024/1024, t/1024/1024}' /proc/meminfo
echo

echo "DISK USAGE:"
LC_NUMERIC=C df -P -B1 --total | tail -1 | awk '{p=$5; gsub(/%/, "", p); printf "  %.1f%% used (%.2f/%.2f GB)\n", p, $3/1e9, $2/1e9}'
echo

echo "TOP CPU:"
ps -eo pid,comm,%cpu --sort=-%cpu | head -6 | awk 'NR==1{print "  PID   CMD         CPU%"} NR>1{printf "  %-6s %-12s %.1f%%\n", $1, $2, $3}'
echo

echo "TOP MEM:"
ps -eo pid,comm,rss --sort=-rss | head -6 | awk 'NR==1{print "  PID   CMD         MEM(MB)"} NR>1{printf "  %-6s %-12s %.0f\n", $1, $2, $3/1024}'
echo

echo "Updated: $(date)"