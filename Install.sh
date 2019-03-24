#!/bin/bash

username=$1

if [ ! "$username" ] ; then
	username=$USER;
fi

for place in `find * -type d` ; do
  eval target=~${username}/.${place};
  mkdir -vp "${target}";
done

for dotfile in `find * -type f` ; do 
    if [ $dotfile == 'Install.sh' ] ; then
        continue;
    fi
    eval target=~${username}/.${dotfile};
    cp -vf ${dotfile} ${target};
    chown ${username} ${target};
done