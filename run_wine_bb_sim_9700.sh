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

exe="fledge.exe"
## based on Research In Motion/BlackBerry JDE 5.0.0/simulator/9700.bat

#args="/app=Jvm.dll /handheld=9700 /session=9700 /app-param=DisableRegistration /app-param=JvmAlxConfigFile:9700.xml /data-port=0x4d44 /data-port=0x4d4e /pin=0x2100000A"
## TODO try to add sleep to LoadCod execution via passing actionfile path
args="/app=Jvm.dll /handheld=9700 /session=9700 /app-param=DisableRegistration /app-param=JvmAlxConfigFile:9700.xml /data-port=0x4d44 /data-port=0x4d4e /pin=0x2100000A /app-param=JvmDebugFile:C:\9700_debug.log /app-param=execute=LoadCod(\"C:\svgmapdemo.cod\")"
#args="/handheld=9700 /app-param=url:example.com /app=Jvm.dll"
#args="/app=Jvm.dll /app-param=launch=PhoneScreenDemo2.cod /handheld=9700 /session=9700 /data-port=0x4d44 /data-port=0x4d4e /pin=0x2100000A"

if [ ! -f "$exe" ]; then
  echo "$SOURCE error: executable not found: $exe"
  exit 1
fi

##TODO FIXME: 01a0:err:dmloader:IDirectMusicLoaderImpl_SetObject : could not attach stream to file L"C:\\windows\\system32\\drivers\\gm.dls", make sure it exists on loading the program

#wine "$exe" /help
#javaloader -usb load

echo "[TODO] [QoL] make the window with the simulator floating and position it on the screen ( see Links cat project as an example )"

wine "$exe" $args

## maybe
## /app-param=launch=com.popcap.peggle ## causes memory access violation

## not working
## "/app-param=launch="svgmapdemo.cod"
## "/app-param=launch=HelloWorldDemo.cod"
## "/app-param=launch=\"C:\\Program Files\\Research In Motion\\BlackBerry JDE 5.0.0\\simulator\\HelloWorldDemo.cod\""
## "/app-param=launch=http://example.com"


## /eventfile="C:\eventfiles\open_menu_downloads_first_app.event"
