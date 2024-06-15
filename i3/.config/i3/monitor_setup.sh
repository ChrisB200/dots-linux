#!/bin/bash

# Detect the connected monitors
connected_monitors=$(xrandr --query | grep " connected" | cut -d ' ' -f1)

# List of monitors
monitor1="HDMI-1"
monitor2="DP-1"
monitor3="eDP-1"

# Example configuration: Dual monitors with specific positioning
if [[ "$connected_monitors" == *"$monitor1"* && "$connected_monitors" == *"$monitor2"* ]]; then
    xrandr --output "$monitor1" --primary --mode 1920x1080 --pos 0x0 --rotate normal \
           --output "$monitor2" --mode 1920x1080 --pos 1920x0 --rotate normal \
           --output "$monitor3" --off
elif [[ "$connected_monitors" == *"$monitor1"* ]]; then
    xrandr --output "$monitor1" --primary --mode 1920x1080 --pos 0x0 --rotate normal \
           --output "$monitor2" --off \
           --output "$monitor3" --off
elif [[ "$connected_monitors" == *"$monitor3"* ]]; then
    xrandr --output "$monitor3" --primary --mode 1366x768 --pos 0x0 --rotate normal \
           --output "$monitor1" --off \
           --output "$monitor2" --off
else
    xrandr --output "$monitor1" --off \
           --output "$monitor2" --off \
           --output "$monitor3" --off
fi

