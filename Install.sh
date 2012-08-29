#!/bin/bash

username=$1

srcs=*

for dotfile in $srcs ; do 
    if [ $dotfile == 'Install.sh' ] ; then
        continue;
    fi
    eval target=~${username}/.${dotfile};
    cp -vf ${dotfile} ${target};
    chown ${username} ${target};
done