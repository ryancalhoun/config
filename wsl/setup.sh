#!/bin/bash

mkdir -p ~/.local/share/applications/
ln -sf $(readlink -f $(dirname $0))/cmdstart.desktop ~/.local/share/applications/cmdstart.desktop
ln -sf $(readlink -f $(dirname $0))/mimeapps.list ~/.local/share/applications/mimeapps.list

settings_file=$(find /mnt/c/Users/Ryan/AppData/Local/Packages/Microsoft.WindowsTerminal* -name settings.json)
cp $(dirname $0)/settings.json $settings_file
