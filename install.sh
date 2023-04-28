#!/bin/bash

if [ ! -d $HOME/.conf ]; then
	echo "Error: You must place in ~/.conf";
	exit 1
fi

cd $HOME
for f in `ls .conf/conf.d`; do
	if [ -d .$f ]; then
		rm -rf .$f
	fi
	ln -sf .conf/conf.d/$f .$f
	echo $HOME/.$f
done

chmod 700 $HOME/.conf/conf.d/ssh
