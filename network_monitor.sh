#!/bin/bash

# The goal of the program is to check and log network activity for 10 minutes (600 seconds)
# in 30 second intervals

DURATION=600
INTERVAL=30
END_TIME=$(( $(date +%s) + DURATION ))

# An attempt to export data to excel automatically vs manually
OUTPUT_FILE="network_activity.csv"

# Print header to file
echo "Time,ESTABLISHED,LISTEN" > $OUTPUT_FILE

# Monitor network activity
while [ $(date +%s) -le $END_TIME ]; do
	# Prints the current time
	echo "Time: $(date '+%Y-%m-%d %H:%M:%S')"

	# Capture network activity for ESTABLISHED/LISTEN
	ESTABLISHED_NUM=$(netstat -an | grep ESTABLISHED | wc -l)
	LISTEN_NUM=$(netstat -an | grep LISTEN | wc -l)

	echo "$CURRENT_TIME,$ESTABLISHED_NUM,$LISTEN_NUM" >> $OUTPUT_FILE

	sleep $INTERVAL
done
