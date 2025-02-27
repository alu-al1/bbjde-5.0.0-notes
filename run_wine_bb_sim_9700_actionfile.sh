#!/bin/bash

source $BASH_UTILS              2>/dev/null || echo "'\$BASH_UTILS' is not set to `source`"
source "$(dirname $0)/utils.sh" 2>/dev/null || echo "no local utils.sh found to `source`"

## TODO
## ...TODO check_util "wine wine "type -p wine" "wine --version" 
## ...TODO [ ! -z "$DEPS_ERROR" ] && <print deps error one by one into stderr>

set -ex
set_source_and_dir "$0"

## TODO 
# actionfile=$1
# [ -z "$actionfile" ] && echo "Usage: $0 app_name" && exit 1 || echo

## TODO as an arg
sessionname=9700

export WINEPREFIX="$DIR"/wine
## find -L . -name ... # -L for following links
## winecfg

simhome="$WINEPREFIX"/drive_c/Program\ Files/Research\ In\ Motion/BlackBerry\ JDE\ 5.0.0/simulator

cd "$simhome" || exit 1

# TODO prepare interactive variant
# wine cmd /c "fledgecontroller.exe /session=$sessionname < C:\actionfiles\sample.txt"

wine cmd /c "fledgecontroller.exe /help"
wine cmd /c "fledgecontroller.exe /get-sessions"

## TODO as an arg
# wine cmd /c "fledgecontroller.exe /session=$sessionname /execute=AllowFocusChange"

wine_cod_path="C:\dev\svgmapdemo.cod"
wine cmd /c "fledgecontroller.exe /session=$sessionname"
## LoadCod(\"""$wine_cod_path""\")
