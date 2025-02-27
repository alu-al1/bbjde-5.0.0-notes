#!/bin/bash

source $BASH_UTILS              2>/dev/null || echo "'\$BASH_UTILS' is not set to `source`"
source "$(dirname $0)/utils.sh" 2>/dev/null || echo "no local utils.sh found to `source`"

## TODO check on wine
set -ex
set_source_and_dir "$0"

export WINEPREFIX="$DIR"/wine
## find -L . -name ... # -L for following links
## winecfg

simhome="$WINEPREFIX"/drive_c/Program\ Files/Research\ In\ Motion/BlackBerry\ JDE\ 5.0.0/simulator

## **Ensure correct working directory**
cd "$simhome" || exit 1

exe="fledgelauncher.exe"
## based on Research In Motion/BlackBerry JDE 5.0.0/simulator/9700.bat

args=

if [ ! -f "$exe" ]; then
  echo "$SOURCE error: executable not found: $exe"
  exit 1
fi

wine "$exe" $args
