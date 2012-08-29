#!/bin/bash

user=$1 || $USER

srcs=*

for dotfile in $srcs ; do 
    if [ $dotfile == 'Install.sh' ] ; then
        continue;
    fi
    cp -vf ${dotfile} ~${user}/.${dotfile};
    chown $user ~${user}/.${dotfile};
done