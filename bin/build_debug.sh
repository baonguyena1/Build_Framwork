#!/bin/bash

set -e

SRCROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"/..
cd $SRCROOT
SRCROOT=`pwd`

$SRCROOT/bin/setup_carthage.sh beta Debug