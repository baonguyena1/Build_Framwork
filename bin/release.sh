#!/bin/bash

set -e

RED='\033[0;31m'
NC='\033[0m' # No Color

VERSION=""
BRANCH="main"
SRCROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"/..
cd $SRCROOT
SRCROOT=`pwd`
echo -e "${RED}###${NC} Current directory ${SRCROOT}."
CONFIG="config.xcconfig"

function checkoutSource {
    echo -e "${RED}###{NC} Checkout source code from git branch."
    cd $SRCROOT
    git reset --hard
    git checkout $BRANCH
    git fetch; git pull
}

function buildDependencies {
    echo -e "${RED}###${NC} Build dependencies."
    cd $SRCROOT
    $SRCROOT/bin/setup_carthage.sh beta Release
}

function getConfig {
    echo -e "${RED}###${NC} Build dependencies."
    cd $SRCROOT
    source $SRCROOT/bin/$CONFIG
    echo -e "${RED}###${NC} Build version: ${VERSION}"
}

function releaseCarthage {
    git reset --hard
    git tag "v${VERSION}"
    git push origin $BRANCH --tags
}

checkoutSource

getConfig

buildDependencies

releaseCarthage
