#!/bin/bash

echo "=== SYSTEM HEALTH REPORT ==="

# Simple system health check
# Checks disk, memory, and CPU usage.

check_disk () {
   echo "=== DISK ==="
   THRESHOLD=80

  # Check each filesystem and report if usage is too high
  df -h | awk 'NR>1 {sub(/%/,"",$5); print $1, $5}' | while read fs used; do
     if [[ "$fs" == /dev/* ]]; then
       if [[ "$used" -ge "$THRESHOLD" ]]; then
         echo "ALERT: $fs at $used%"
       else
         echo "OK: $fs at $used%"
        fi
       fi
   done
}

check_memory () {
   echo "=== MEMORY ==="
   THRESHOLD=80

  # Get total and used memory in MB
  read total used < <(free -m | awk 'NR==2 {print $2, $3}')
  used_percent="$((used * 100 / total))"

  if [[ "$used_percent" -ge "$THRESHOLD" ]]; then
      echo "ALERT: memory at $used_percent%"
  else
    echo "OK: memory at $used_percent%"
  fi
}

check_cpu () {
   echo "=== CPU ==="
   THRESHOLD=1

  # Get the 1 minute load average
  load=$(uptime | awk '{sub(/,/,"",$9); print $9}')

  if awk "BEGIN {exit ! (Sload >= 1.0 )}"; then
    echo "ALERT: CPU load high at $load"
  else
    echo "OK: CPU load fine at $load"
   fi
}

# --- run the checks ---
check_disk
check_memory
check_cpu
