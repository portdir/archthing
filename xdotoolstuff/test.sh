#!/bin/bash
# casts typer

# Settings
readfile="$PWD/theTEXT.txt"
TEXTdelay="90" # in ms
TEXTsleep="1" # in s
HOLDtotype="2" # in s

# TEXT
TEXT="$(<$readfile)"
# Functions

SeeDependency(){
    if [ -e "$readfile" ]; then
        echo -e "file $readfile "
    else
        echo "file is MISSING"
        touch $readfile
        cleanup
    fi
    if command -v xdotool >/dev/null 2>&1 ; then
        echo -e "xdotool installed"
    else
        echo "xdotool is MISSING"
        cleanup
    fi
}
countdown(){
    TEXTwcc=$(wc -c < "$readfile")
    TEXTwcl=$(wc -l < "$readfile")
    lettertime=$((TEXTwcc * TEXTdelay))
    lettertimesec=$((lettertime / 1000))
    linetime=$((TEXTwcl * TEXTsleep))
    thetimeoutput=$((lettertimesec + linetime))
    
    echo "Estimated time: ${thetimeoutput}s"
    local n=$thetimeoutput
    while [ "$n" -gt 0 ]; do
        printf "\rTime remaining: %02d:%02d " $((n / 60)) $((n % 60))
        sleep 1
        n=$((n - 1))
    done
    echo "Done!"
}
xdotooltext(){
    echo "$TEXT" | while read -r line; do
        xdotool type --delay "$TEXTdelay" "$line"
        sleep "$TEXTsleep"
        xdotool key Return
    done
}

cleanup(){
    echo -e "\n[STOPPING]"
    kill -- -$$ 2>/dev/null || true &
    trap - INT TERM
    exit 130
}
runing(){
    sleep "$HOLDtotype"
    SeeDependency
    xdotooltext &
    countdown
    sleep 0.1
    cleanup
}
# RUN IN FOREGROUND
trap cleanup INT TERM
runing
