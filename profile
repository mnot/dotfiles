#!/bin/bash

. $HOME/.bashrc

bind '"\e[5C": forward-word'
bind '"\e[5D": backward-word'

#if [ -f "`which screen`" ]; then
#	screen -RR;
#fi