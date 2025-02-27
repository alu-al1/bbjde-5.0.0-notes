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

## TODO check on wine mkfifo socat

set -ex

type -p wine && wine --version

fifopipe=$1
sessionname=$2

#TODO Usage as a separate routine

[ -z "$fifopipe" ] && echo -en "Arg error: No fifo pipe given.\nUsage $0 fifopipe [session=first_session_found]\n" && exit 1 || echo
[ -p "$fifopipe" ] || mkfifo "$fifopipe"
[ -p "$fifopipe" ] || { echo -en "error: Failed to ensure fifo pipe $fifopipe.\n"; exit 1; }

export WINEPREFIX="$DIR"/wine

if [ -z "$sessionname" ]; then
	sessionname=$(wine cmd /c "fledgecontroller.exe /get-sessions" | head -n1)
fi

[ -z "$sessionname" ] && echo -en "Arg error: No session name given and no active sessions found.\nUsage $0 fifopipe [session=first_session_found]\n" && exit 1 || echo


wine cmd /c "echo %PATH% & fledgecontroller.exe /help"

# or stdbuf -i0 some_command < my_pipe
# or exec 3<> my_pipe && some_command <&3
wine_cmd_c="fledgecontroller.exe /session=$sessionname"
socat -u PIPE:"$fifopipe" EXEC:'wine cmd /c '"$wine_cmd_c"
