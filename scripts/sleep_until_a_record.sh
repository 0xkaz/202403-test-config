#!/bin/bash

# Check if the correct number of arguments are passed
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <domain> <log_file_path>"
    exit 1
fi

# The target domain name
DOMAIN="$1"
# Path to the log file
LOG_FILE="$2"

# Loop until an A record is found
while true; do
    # Use dig command to search for A records
    IP=$(dig +short A $DOMAIN)

    # Get the current date and time
    NOW=$(date +"%Y-%m-%d %H:%M:%S")

    if [[ -n $IP ]]; then
        # If an A record is found, log it and exit the loop
        echo "[$NOW] A record for $DOMAIN found: $IP" | tee -a $LOG_FILE
        break
    else
        # If no A record is found, log the attempt and sleep
        echo "[$NOW] A record for $DOMAIN not found, retrying..." | tee -a $LOG_FILE
        sleep 5 # Sleep for 5 seconds
    fi
done