#!/bin/bash
# casts typer

# Settings
readfile="$PWD/input.tcl"
TEXTdelay="20" # in ms
TEXTsleep="1" # in s
HOLDtotype="3" # in s

thetimeoutput=$(( ($(wc -c < "$readfile") * TEXTdelay / 1000) + ($(wc -l < "$readfile") * TEXTsleep) ))
# Functions

SeeDependency(){
if [ ! -f "$readfile" ] || ! command -v xdotool &>/dev/null; then
    [ ! -f "$readfile" ] && touch "$readfile" && echo "file MISSING (created empty)" || echo "xdotool MISSING"
    cleanup
fi
}

countdown(){
    local n=$thetimeoutput
    echo "Estimated time: ${n}s"
    while [ "$n" -gt 0 ]; do
        printf "\rTime remaining: %02d:%02d" $((n / 60)) $((n % 60))
        sleep 1
        n=$((n - 1))
    done
    echo -e"\n Done!"
}
xdotooltext(){
    while IFS= read -r line; do
        if [[ "$line" =~ ^[[:space:]]*# ]]; then
            cleanup
        fi
        xdotool type --delay "$TEXTdelay" "$line"
        sleep "$TEXTsleep"
        xdotool key Return
    done < "$readfile"
}
cleanup(){
    echo -e "\n[STOPPING]"
    kill -- -$$ 2>/dev/null || true &
    trap - INT TERM
    exit 1
}
runing(){
    SeeDependency &
    echo "time $HOLDtotype till start"
    sleep "$HOLDtotype"
    xdotooltext &
    countdown
    sleep 0.2
    cleanup
}
trap cleanup INT TERM
runing
