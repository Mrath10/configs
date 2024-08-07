#!/bin/bash

# Set environment variables
#export WAYLAND_DISPLAY=wayland-0
export XDG_CURRENT_DESKTOP=wlr

# Update the dbus activation environment
#dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP

# Restart services to pick up new environment variables
#systemctl --user stop pipewire wireplumber xdg-desktop-portal xdg-desktop-portal-wlr
#systemctl --user start wireplumber

rclone --vfs-cache-mode writes mount OneDrive: ~/OneDrive &

dwl > ~/.cache/dwltags
