#!/bin/bash

# CPU load check
# Alerts if the 1 minute load average is at or above the threshold
THRESHOLD=1

# Get the current 1 minute load average
load=$(uptime | awk '{sub(/,/,"",$9); print $9}')

if awk "BEGIN {exit !($load >= $THRESHOLD)}"; then
   echo "ALERT: cpu load high at $load"
else
   echo "OK: cpu load fine at $load"
fi
