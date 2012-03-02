#!/bin/bash

srcs=*

for dotfile in $srcs ; do 
    if [ $dotfile == 'Install.sh' ] ; then
        continue;
    fi
    cp -vf ${dotfile} ~/.${dotfile};
done