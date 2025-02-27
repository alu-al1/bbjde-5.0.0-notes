#!/bin/bash

function i3wm_get_focused_output()
{
    i3-msg -t get_tree | \
    jq -r '.. | select( type == "object") | select(.focused==true) | .output'
}

function get_mon_wh_leftmost()
{
    local output=$1
    xrandr --query \
    | awk \
        -v var_output="$output" \
        '/.*'${output}'.*connected.*/ {
            leftmost[1]=0
            leftmost[2]=0

            res_pos_mask = /[0-9]+x[0-9]+\+[0-9]+\+[0-9]+/
            if($3 ~ res_pos_mask)
            {
                    res_pos=$3
            }
            else if($4 ~ res_pos_mask)
            {
                    res_pos=$4
            }
            else {
                    next
            }
            split(res_pos, arr, /[x+]/);
            if (arr[3] == leftmost[1] && arr[4] == leftmost[2]) {
                    #print arr[1], arr[2], arr[3], arr[4];
                    print arr[1], arr[2]
                    exit
            }
        }'
}


# use xprop on an existing window to get its title
window_name="Links"

## TODO implement something like: i3wm_wait_event_and_do <event> i3wm_place_window $@
## TODO implement something like: i3wm_wait_ms_and_do <ms> i3wm_place_window $@
function i3wm_place_window
{ 
local window_name=$1; [ -z "window_name" ] && echo "i3wm_place_window: no window_name passed" && exit 1
local twelve_fraction_x=$2; if [ -z "twelve_fraction_x" ]; then twelve_fraction_x=1; fi 
local twelve_fraction_y=$3; if [ -z "twelve_fraction_y" ]; then twelve_fraction_y=1; fi


focused_display_resolution="$(get_mon_wh_leftmost $(i3wm_get_focused_output))"
x1=$(echo $focused_display_resolution | cut -d" " -f1)
y1=$(echo $focused_display_resolution | cut -d" " -f2)

#TODO get it from the window
wpx=800
hpx=600

## note: add border pixel 0 to remove window decorations
i3_cmd=$(echo "[title=\"$window_name\"] \
        floating enable, \
        move position \
        $((x1 / 12 * twelve_fraction_x)) \
        $((y1 / 12 * twelve_fraction_y))")

## TODO ensure picom has a specific opacity rule for the window class


## TODO move it to i3wm_wait... variants

## TODO sleep for possible compile duration mb?
## ...TODO mb call eval with waiting for $! to receive a syscall ($! should be `go run ...` pid at that point)
        for ((i=1; i<=10; i++)); do
                sleep 0.5
                if [ $(i3-msg $i3_cmd | jq 'length') -ne 0 ]; then
                        break; 
                fi
        done;
        # TODO wait for pid if any or exit
}


