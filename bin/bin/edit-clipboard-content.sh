#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Edit Clipboard Content
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🤖

# Documentation:
# @raycast.author Hrishi Hiraskar
# @raycast.authorURL https://github.com/Hrily

nvim +'silent pu!+' +'$d' +'1' +'au BufWriteCmd vimclippy %y+ | set nomodified' vimclippy
