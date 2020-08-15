#!/bin/bash
DEVICE=oneplus3
# if you want to build without using ccache, comment
# the next 4 lines
export USE_CCACHE=1
export CCACHE_DIR=~/.ccache
export CCACHE_MAX_SIZE=30G
ccache -M $CCACHE_MAX_SIZE

# encapsulate the build's temp directory.
# This way it's easier to clean up afterwards
TMP=$(mktemp -dt)
TMPDIR=$TMP
TEMP=$TMP

export TMP TMPDIR TEMP

#make sure jack-server is restarted in TMP
prebuilts/sdk/tools/jack-admin stop-server

# we want all compiler messages in English
export LANGUAGE=C

# set up the environment (variables and functions)
unset JAVAC
source build/envsetup.sh

# clean the out dir; comment out, if you want to do
# a dirty build
# make -j9 ARCH=arm clean

# fire up the building process and also log stdout
# and stderrout
breakfast $DEVICE 2>&1 | tee breakfast.log && \
brunch $DEVICE 2>&1 | tee make.log

prebuilts/sdk/tools/jack-admin stop-server

# remove all temp directories
rm -r ${TMP}