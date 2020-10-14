#!/bin/bash

set -e

RED='\033[0;31m'
NC='\033[0m' # No Color

if ! command -v carthage &> /dev/null
then
    echo -e "${RED}###${NC} Carthage is not installed."
    echo -e "${RED}###${NC} See https://github.com/Carthage/Carthage for install instructions.."
    exit
fi

IS_XCODE_BETA="$1"
BUILD_CONFIGURATION="$2"
echo -e "${RED}###${NC} Enviroment: Xcode beta = ${IS_XCODE_BETA}, Build configuration = ${BUILD_CONFIGURATION}"

SRCROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"/..
cd $SRCROOT
SRCROOT=`pwd`
echo -e "${RED}###${NC} Current directory ${SRCROOT}."

CARTHAGE=`command -v carthage`

echo -e "${RED}###${NC} Checkout carthage library."
$CARTHAGE update --platform iOS --cache-builds --no-use-binaries --no-build

echo -e "${RED}###${NC} Export enviroment for carthage build."
xcconfig=$(mktemp /tmp/static.xcconfig.XXXXXX)
trap 'rm -f "$xcconfig"' INT TERM HUP EXIT

# For Xcode 12 make sure EXCLUDED_ARCHS is set to arm architectures otherwise
# the build will fail on lipo due to duplicate architectures.
if [ $IS_XCODE_BETA == "beta" ]
then
    echo 'EXCLUDED_ARCHS__EFFECTIVE_PLATFORM_SUFFIX_simulator__NATIVE_ARCH_64_BIT_x86_64__XCODE_1200 = arm64 arm64e armv7 armv7s armv6 armv8' >> $xcconfig
    echo 'EXCLUDED_ARCHS = $(inherited) $(EXCLUDED_ARCHS__EFFECTIVE_PLATFORM_SUFFIX_$(EFFECTIVE_PLATFORM_SUFFIX)__NATIVE_ARCH_64_BIT_$(NATIVE_ARCH_64_BIT)__XCODE_$(XCODE_VERSION_MAJOR))' >> $xcconfig
fi

## Enable for debug mode
echo "BUILD_LIBRARIES_FOR_DISTRIBUTION = YES" >> ${xcconfig}

echo "DEBUG_INFORMATION_FORMAT = dwarf" >> ${xcconfig}

## Needed for depenencies to find their depenencies
echo "FRAMEWORK_SEARCH_PATHS = \$(inherited) ${SRCROOT}/Carthage/Build/iOS/" >> ${xcconfig}

export XCODE_XCCONFIG_FILE="$xcconfig"

$CARTHAGE build --platform iOS --no-skip-current --cache-builds --no-use-binaries --configuration $BUILD_CONFIGURATION

STATIC_FRAMEWORK_PATH="Carthage/Build/iOS/STATIC"
if [ -d $STATIC_FRAMEWORK_PATH ]
then
    echo -e "${RED}###${NC} Copy static framework to carthage build folder."
    cp -r "${STATIC_FRAMEWORK_PATH}/*.framework" "Carthage/Build/iOS/"
fi

echo -e "Build successfully."