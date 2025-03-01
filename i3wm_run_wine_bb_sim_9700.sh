#!/bin/bash

source $BASH_UTILS              2>/dev/null || echo "'\$BASH_UTILS' is not set to `source`"
source "$(dirname $0)/utils.sh" 2>/dev/null || echo "no local utils.sh found to `source`"

set -ex
set_source_and_dir "$0"

source "$DIR"/i3wm_utils.sh

## use xprop on the window to get its attributes
window_name="BlackBerry 9700 Simulator"

## TODO get rid of sleep and make it more event-based-ish
{ sleep 2; i3wm_place_window "$window_name" 8 2; } \
& \
"$DIR"/run_wine_bb_sim_9700.sh
