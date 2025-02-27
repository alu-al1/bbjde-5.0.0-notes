#!/bin/bash

## standard preamble
## TODO check for dirname, pwd, readlink
## https://stackoverflow.com/questions/59895/how-do-i-get-the-directory-where-a-bash-script-is-located-from-within-the-script
SOURCE=${BASH_SOURCE[0]}
while [ -L "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR=$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )
  SOURCE=$(readlink "$SOURCE")
  [[ $SOURCE != /* ]] && SOURCE=$DIR/$SOURCE # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the sy>
done
DIR=$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )

## TODO check on wine

type -p wine && wine --version

set -ex

## TODO 
# actionfile=$1
# [ -z "$actionfile" ] && echo "Usage: $0 app_name" && exit 1 || echo

## TODO
sessionname=9700

export WINEPREFIX="$DIR"/wine
## find -L . -name ... # -L for following links
## winecfg

simhome="$WINEPREFIX"/drive_c/Program\ Files/Research\ In\ Motion/BlackBerry\ JDE\ 5.0.0/simulator

## **Ensure correct working directory**
cd "$simhome" || exit 1

# TODO prepare interactive variant
# wine cmd /c "fledgecontroller.exe /session=$sessionname < C:\actionfiles\sample.txt"


## Note seems like Notifications demo is blocking the way. Maybe remove all .cod files leaving only one under testing?

# allmost - should see logs
wine cmd /c "fledgecontroller.exe /help"
wine cmd /c "fledgecontroller.exe /get-sessions"
# wine cmd /c "fledgecontroller.exe /session=$sessionname /execute=AllowFocusChange"
wine_cod_path="C:\dev\svgmapdemo.cod"
wine cmd /c "fledgecontroller.exe /session=$sessionname"
## LoadCod(\"""$wine_cod_path""\")
