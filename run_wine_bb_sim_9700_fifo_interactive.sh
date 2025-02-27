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

## TODO rewrite to `utils.check_is_set_or_die_critical"
[ -z "$fifopipe" ] && echo -en "Arg error: No fifo pipe given.\nUsage $0 fifopipe [session=first_session_found]\n" && exit 1 || echo
[ -p "$fifopipe" ] || mkfifo "$fifopipe"
[ -p "$fifopipe" ] || { echo -en "error: Failed to ensure fifo pipe $fifopipe.\n"; exit 1; }

export WINEPREFIX="$DIR"/wine

if [ -z "$sessionname" ]; then
	sessionname=$(wine cmd /c "fledgecontroller.exe /get-sessions" | head -n1)
fi

[ -z "$sessionname" ] && echo -en "Arg error: No session name given and no active sessions found.\nUsage $0 fifopipe [session=first_session_found]\n" && exit 1 || echo


wine cmd /c "echo %PATH% & fledgecontroller.exe /help"
wine_cmd_c="fledgecontroller.exe /session=$sessionname"

# or stdbuf -i0 some_command < my_pipe
# or exec 3<> my_pipe && some_command <&3
socat -u PIPE:"$fifopipe" EXEC:'wine cmd /c '"$wine_cmd_c"
