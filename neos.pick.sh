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

pushd frameworks/base
safer-git remote add 2neos ${REMOTE_URL}/android_frameworks_base.git
safer-git fetch 2neos neos-picks
safer-git cherry-pick 957cf93c70 # packages: settingslib: development settings enabled default 
safer-git cherry-pick b50aff69ac # PackageManager: Don't delete unknown apps 
popd

pushd system/core
safer-git remote add 2neos ${REMOTE_URL}/android_system_core.git
safer-git fetch 2neos neos-picks
safer-git cherry-pick 7fe424d02f # Boot on charger state too
safer-git cherry-pick a01bdc2a5b # add comma permissions to fs_config
popd