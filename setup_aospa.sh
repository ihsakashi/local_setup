#!/bin/bash

source ./env

mkdir -p ${BUILD_ROOT}

if [ -x dep_installed ]; then
    echo "> WARNING: Make sure dependencies are installed"
    echo "> Run setup_deps.sh"
    sleep 5
fi
if [ -z aosp_installed ]; then
    echo "> ERROR: You have already setup aosp"
    echo "> If you have already cleaned environment, delete aosp_installed"
    sleep 5
fi
echo " "

echo "> Init and sync repo"
echo "> This will take some time.."
cd ${BUILD_ROOT}
repo init -u https://github.com/AOSPA/manifest -b quartz
repo sync -j8

echo "> Linking local manifest and resyncing"
mkdir -p ${BUILD_ROOT}/.repo/local_manifests
cd ${BUILD_ROOT}/.repo/local_manifests

ln -s ${LOCAL_MANIFEST}/neos.xml .

repo sync -j8

echo "> Cherry-picking changes"
# NEOS
$DIR/neos.pick.sh

echo "> Linking AOSPA build script"
cd ${BUILD_ROOT}
ln -s $DIR/my_build.sh ./my-build

echo "> Done!"
echo "> Run ${BUILD_ROOT}/my-build to build AOSPA"
touch aosp_installed