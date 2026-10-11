#!/bin/bash

# Set the disk usage percentage that will trigger the alarm
THRESHOLD=80

# Get disk usage information, skip the header row,
# remove the percentage sign from the usage value,
# and print the filesystem name and usage percentage.
df -h | awk 'NR>1 {sub(/%/,"",$5); print $1, $5}' | while read fs used; do

  # Check whether the filesystem name begins with /dev/.
  # If it does, continue to the next file system.
  if [[ "$fs" == /dev/* ]]; then

   # Check whether disk usage is greater than or equal,
   # to the defined threshold.
   if [[ "$used" -ge "$THRESHOLD" ]]; then

     # Display an alert if disk usage reaches the threshold.
      echo "ALERT: $fs is at $used%"

      else

        # Display an OK message if disk usage is below the threshold
         echo "OK: $fs at $used%"
     fi

   fi
done
