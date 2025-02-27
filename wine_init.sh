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

echo "Yet Untested"
exit 69

set -ex

type -p wine && wine --version

## TODO parameterize
export WINEPREFIX="$DIR"/wine
export WINEARCH=win64
## TODO decompress a wine dir archive file if provided
[ ! -d "$WINEPREFIX" ] && wineboot --init || echo noop
[ -d "$DIR/regs" ] && find -L "$DIR/regs" -name "*.reg" -type f -exec  WINEPREFIX="$WINEPREFIX" wine regedit /s {} ;\ || echo "no .regs to apply"

