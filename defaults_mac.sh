#!/bin/sh
defaults write -g InitialKeyRepeat -int 15
defaults write -g KeyRepeat -int 1
echo “[default]” > /etc/nsmb.conf
echo signing_required=no >> /etc/nsmb.conf

