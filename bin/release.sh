#!/bin/bash

set -e

RED='\033[0;31m'
NC='\033[0m' # No Color

SRCROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"/..
cd $SRCROOT
SRCROOT=`pwd`
echo -e "${RED}###${NC} Current directory ${SRCROOT}."

function build_dependencies {
    echo -e "${RED}###${NC} Build dependencies."
    cd $SRCROOT
    bin/setup_carthage.sh beta Release
}

function release {
    BUILD_CONFIGURATION="Release"
}

build_dependencies

release
