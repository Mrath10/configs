#!/bin/bash

# Get the current volume of the default sink
current_volume=$(pactl list sinks | grep '^[[:space:]]Volume:' | head -n $(( $(pactl list sinks short | wc -l) + 1)) | tail -n 1 | awk '{print $5}' | tr -d '%')

# Define the volume increment
increment=5

# Calculate the new volume
new_volume=$((current_volume + increment))

# Check if the new volume exceeds 100%
if [ $new_volume -gt 100 ]; then
  new_volume=100
fi

# Set the new volume
pactl set-sink-volume @DEFAULT_SINK@ ${new_volume}%

