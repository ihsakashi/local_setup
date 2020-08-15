#!/bin/bash
# Ubuntu 20.04 Machine

# Dependencies
echo "> Installing dependencies"
sudo apt-get update -y
sudo apt-get install -y bc bison build-essential ccache curl flex g++-multilib gcc-multilib git git-lfs gnupg imagemagick lib32ncurses-dev lib32readline-dev lib32z1-dev liblz4-tool libncurses5 libncurses5-dev libsdl1.2-dev libssl-dev libxml2 libxml2-utils lzop pngcrush rsync schedtool brotli squashfs-tools xsltproc zip zlib1g-dev libwxgtk3.0-gtk3-dev python2 python3 android-tools-mkbootimg openjdk-11-jdk openjdk-11-jre nodejs yarnpkg

# Python2 for AOSP
sudo ln -s /usr/bin/python2.7 /usr/bin/python

# Repo
echo "> Installing git repo"
mkdir -p ~/bin
curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
sudo chmod a+x ~/bin/repo
source ~/.profile

# Finish
echo "> Done!"
touch dep_installed