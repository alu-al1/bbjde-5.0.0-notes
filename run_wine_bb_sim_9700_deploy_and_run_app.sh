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
## TODO if ! sessionname - get the first one from `/get-sessions` call
sessionname=9700
check_is_set_or_die_critical "$sessionname" "No session name is provided to attach to\nTODO: Usage\n"
app="$1" # cod file that can be found at C:\dev aka $WINEPREFIX/drive_c/dev
check_is_set_or_die_critical "$app" "No app name provided for deploy and run\nTODO: Usage\n"
## TODO check exists on src directory
## TODO check is .cod

export WINEPREFIX="$DIR"/wine
## find -L . -name ... # -L for following links
## winecfg
host_cod_src_dir="$WINEPREFIX/drive_c/dev"
mkdir -p "$host_cod_src_dir"

simhome="$WINEPREFIX"/drive_c/Program\ Files/Research\ In\ Motion/BlackBerry\ JDE\ 5.0.0/simulator
cd "$simhome" || check_is_set_or_die_critical "" "`\$simhome` is empty or couldn't be found"
## TODO check wine actually sees it
wine_simhome="C:\Program Files\Research In Motion\BlackBerry JDE 5.0.0\simulator"

# TODO prepare interactive variant
# wine cmd /c "fledgecontroller.exe /session=$sessionname < C:\actionfiles\sample.txt"

wine cmd /c "fledgecontroller.exe /help"
wine cmd /c "fledgecontroller.exe /get-sessions"

## TODO as an arg
# wine cmd /c "fledgecontroller.exe /session=$sessionname /execute=AllowFocusChange"

# TODO check is regular file and is .cod
wine_cod_path_simhome_rel=$( basename "$app" )

rm -rf                                      "$simhome/$wine_cod_path_simhome_rel"
cp "$host_cod_src_dir/$app"                 "$simhome/$wine_cod_path_simhome_rel"

cat "$simhome/$wine_cod_path_simhome_rel"	| md5sum
cat "$host_cod_src_dir/$app"			| md5sum

#debug
find "$simhome" -maxdepth 1 -name "*.cod" -type f

cod_="\"$wine_simhome\\$wine_cod_path_simhome_rel\""
cod_="\"$wine_cod_path_simhome_rel\""
echo "will load cod: $cod_"
echo "as LoadCod\($cod_)"


wine cmd /c "fledgecontroller.exe /session=$sessionname /execute=LoadCod($cod_)"
wine cmd /c "fledgecontroller.exe /session=$sessionname" << EOF

Pause( 1)
KeyPress( END, 1 )
KeyRelease( END, 0 )
KeyPress( END, 1 )
KeyRelease( END, 0 )
Pause( 1 )
KeyPress( FRONT_CONVENIENCE, 1 )
KeyRelease( FRONT_CONVENIENCE, 0 )
Pause( 1 )
ThumbwheelRoll( -1 )
ThumbwheelRoll( -1 )
ThumbwheelRoll( -1 )
ThumbwheelRoll( -1 )
ThumbwheelRoll( -1 )
ThumbwheelRoll( -1 )
ThumbwheelRoll( -1 )
ThumbwheelRoll( -1 )
ThumbwheelRoll( -1 )
ThumbwheelRoll( -1 )
ThumbwheelRoll( -1 )
ThumbwheelRoll( -1 )
ThumbwheelRoll( -1 )
ThumbwheelRoll( -1 )
ThumbwheelRoll( -1 )
ThumbwheelRoll( -1 )
ThumbwheelRoll( -1 )
ThumbwheelRoll( -1 )
ThumbwheelRoll( -1 )
ThumbwheelRoll( -1 )
ThumbwheelRoll( -1 )
ThumbwheelRoll( -1 )
ThumbwheelRoll( -1 )
ThumbwheelRoll( -1 )
ThumbwheelRoll( -1 )
ThumbwheelRoll( -1 )
ThumbwheelRoll( -1 )
ThumbwheelRoll( -1 )
ThumbwheelRoll( -1 )
ThumbwheelRoll( -1 )
ThumbwheelRoll( -1 )
ThumbwheelRoll( -1 )
ThumbwheelRoll( -1 )
ThumbwheelRoll( -1 )
ThumbwheelRoll( -1 )
ThumbwheelRoll( -1 )
ThumbwheelRoll( -1 )
ThumbwheelRoll( -1 )
ThumbwheelRoll( -1 )
ThumbwheelRoll( -1 )
ThumbwheelRoll( -1 )
ThumbwheelRoll( -1 )
ThumbwheelRoll( -1 )
ThumbwheelRoll( -1 )
ThumbwheelRoll( -1 )
ThumbwheelRoll( -1 )
ThumbwheelRoll( -1 )
ThumbwheelRoll( -1 )
ThumbwheelRoll( -1 )
Pause( 1 )
ThumbwheelRoll( 1 )
ThumbwheelRoll( 1 )
ThumbwheelRoll( 1 )
ThumbwheelRoll( 1 )
ThumbwheelRoll( 1 )
ThumbwheelRoll( 1 )
ThumbwheelRoll( 1 )
ThumbwheelRoll( 1 )
ThumbwheelRoll( 1 )
ThumbwheelRoll( 1 )
ThumbwheelRoll( 1 )
Pause( 1 )
ThumbwheelRoll( 1 )
ThumbwheelRoll( 1 )
ThumbwheelRoll( 1 )
TrackballPress(  )
TrackballRelease(  )
Pause( 1 )
TrackballPress(  )
TrackballRelease(  )

EOF
