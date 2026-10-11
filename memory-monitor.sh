#!/bin/bash
# Memory usage monitor.
# Alerts if used RAM is at or above the threshold.

THRESHOLD=80

# Get total and used memory in Mib
read total used < <(free -m | awk 'NR==2 {print $2, $3}')

percent="$((used * 100 / total))"

if [[ "$percent" -ge "$THRESHOLD" ]]; then
   echo "ALERT: memory is at $percent%"
else
   echo "OK: memory at $percent%"
fi
