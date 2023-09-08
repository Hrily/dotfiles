#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Insert Current Date
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 📅

# Documentation:
# @raycast.author Hrishi Hiraskar
# @raycast.authorURL https://github.com/Hrily

osascript <<'END'
  on run {}
    set dateString to do shell script "date +'%Y-%m-%d'"
    tell application "System Events"
      keystroke dateString
    end tell
  end run
END
