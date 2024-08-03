#!/bin/bash

dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP

#Restart services to pickup enviroment change
#systemctl --user stop pipewire wireplumber xdg-desktop-portal xdg-desktop-portal-wlr
#systemctl --user start wireplumber

