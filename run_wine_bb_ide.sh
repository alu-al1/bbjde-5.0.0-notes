#!/bin/bash

source $BASH_UTILS              2>/dev/null || echo "'\$BASH_UTILS' is not set to `source`"
source "$(dirname $0)/utils.sh" 2>/dev/null || echo "no local utils.sh found to `source`"

## TODO check on wine
set -ex
set_source_and_dir "$0"

export WINEPREFIX="$DIR"/wine
## find -L . -name ... # -L for following links
## winecfg
## wine regedit

wine cmd /c "pushd C:\Program Files\Research In Motion\BlackBerry JDE 5.0.0\bin && start ide.bat"
