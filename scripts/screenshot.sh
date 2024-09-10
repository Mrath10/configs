#!/bin/bash
# #Script to take a screenshot of a selected area and save it to the screenshots folder 
grim -g "$(slurp)" "$HOME/Pictures/screenshots/$(date +'%screenshot_%Y-%m-%d-%H%M%S.png')"

