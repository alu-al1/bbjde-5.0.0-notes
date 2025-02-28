#!/bin/bash

source $BASH_UTILS              2>/dev/null || echo "'\$BASH_UTILS' is not set to `source`"
source "$(dirname $0)/utils.sh" 2>/dev/null || echo "no local utils.sh found to `source`"

## TODO check on wine mkfifo socat
## TODO check on type -p wine && wine --version
set -ex
set_source_and_dir "$0"

fifopipe=$1
sessionname=$2

## TODO Usage as a separate routine

export WINEPREFIX="$DIR"/wine

if [ -z "$sessionname" ]; then
    sessionname=$(wine cmd /c "fledgecontroller.exe /get-sessions" | head -n1 | tr -d '\r')
fi

[ -z "$sessionname" ] && echo -en "Arg error: No session name given and no active sessions found.\nUsage $0 fifopipe [session=first_session_found]\n" && exit 1 || echo


## TODO rewrite to `utils.check_is_set_or_die_critical"
## TODO interactive mode
directmode=0
if [ -z "$fifopipe" ];then
    echo -en "No fifopipe is given, switching to direct mode.\n\n"
    directmode=1
else
    [ -p "$fifopipe" ] || mkfifo "$fifopipe"
    [ -p "$fifopipe" ] || { echo -en "error: Failed to ensure fifo pipe $fifopipe.\n"; exit 1; }
fi

wine cmd /c "echo %PATH% & fledgecontroller.exe /help"
wine_cmd_c="fledgecontroller.exe /session=$sessionname"


if [ "$directmode" -ne 0 ]; then
    wine cmd /c "$wine_cmd_c" <&1
else
    # socat -u PIPE:"$fifopipe" EXEC:'wine cmd /c '"$wine_cmd_c"	## Issue: not working for me for now
    # stdbuf -i0 wine cmd /c "$wine_cmd_c" < "$fifopipe"			## Issue: oneshot and then closes
    exec 3<> "$fifopipe" && wine cmd /c "$wine_cmd_c" <&3
fi