#!/bin/bash

source ./env

export BUILD_ROOT LOCAL_MANIFEST

cd ${BUILD_ROOT}

source build/envsetup.sh

safer-git() {
    git $*
    if [ "$?" -gt "0" ] ; then
      read -p "$0 $*: ENTER to continue"
    fi
}

pushd vendor/pa
safer-git remote add neos ${REMOTE_URL}/android_vendor_pa.git
safer-git fetch neos quartz
safer-git cherry-pick dbaf7bc2d9 # include neos vendor
popd

pushd frameworks/base
safer-git remote add neos ${REMOTE_URL}/android_frameworks_base.git
safer-git fetch neos quartz
safer-git cherry-pick 7a3b71aea4 # packages: settingslib: development settings enabled default 
safer-git cherry-pick a9e285ee09 # PackageManager: Don't delete unknown apps 
popd

pushd system/core
safer-git remote add neos ${REMOTE_URL}/android_system_core.git
safer-git fetch neos quartz
safer-git cherry-pick 40cac9f8b7 # Boot on charger state too
safer-git cherry-pick 40cac9f8b7 # add comma permissions to fs_config
popd