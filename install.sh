#!/bin/bash

# definitions
# ------------------------------------------------------------------------------
ROOT_DIR=.conf
FILE_DIR=conf.d

# check
# ------------------------------------------------------------------------------
CURR_DIR=$(pwd)
cd ~
HOME_DIR=$(pwd)
if [ $CURR_DIR != $HOME_DIR/$ROOT_DIR ]; then
	echo "ERROR: You must execute in ~/$ROOT_DIR/";
	exit
fi

# symbolic linking
# ------------------------------------------------------------------------------
cd $HOME_DIR
ITEM=$(ls $ROOT_DIR/$FILE_DIR)
for CF in ${ITEM[*]}
do
	if [ -d $HOME_DIR/.$CF ]
	then
		rm -rf $HOME_DIR/.$CF
	fi
	ln -sf $ROOT_DIR/$FILE_DIR/$CF .$CF
	echo $HOME_DIR/.$CF
done

# permission
# ------------------------------------------------------------------------------
chmod 700 $ROOT_DIR/$FILE_DIR/ssh
