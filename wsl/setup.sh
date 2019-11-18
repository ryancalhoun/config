#!/bin/bash

mkdir -p ~/.local/share/applications/
ln -sf $(readlink -f $(dirname $0))/cmdstart.desktop ~/.local/share/applications/cmdstart.desktop
ln -sf $(readlink -f $(dirname $0))/mimeapps.list ~/.local/share/applications/mimeapps.list
