#!/bin/bash

# see ~/Library/LaunchAgents/com.matlowery.mountsparsebundle.plist

if [ -d ~/Dropbox/notes.sparsebundle ]; then
    hdiutil attach ~/Dropbox/notes.sparsebundle
fi
