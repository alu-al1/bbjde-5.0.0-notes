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
set -ex

export WINEPREFIX="$DIR"/wine
## find -L . -name ... # -L for following links
## winecfg
## wine regedit

wine cmd /c "pushd C:\Program Files\Research In Motion\BlackBerry JDE 5.0.0\bin && start ide.bat"
