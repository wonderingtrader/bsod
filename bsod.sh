#!/bin/sh

tput reset
printf "\033[44m"
printf "\033[38;2;255;255;255m"
printf "\033[2J"
printf "\033[?25l"
printf "\033]11;#0000AA\033\\"

if [ "$1" = "--qrcode" ]; then
    cat << 'EOF'



                    :(
                    Your PC ran into a problem and needs to restart. We're
                    just collecting some error info, and then we'll restart
                    for you.



                    0% complete



EOF
    if command -v qrencode >/dev/null 2>&1; then
        qrencode -t UTF8 -i -m 0 -s 2 "https://windows.com/stopcode" | while IFS= read -r line; do
            cols=$(tput cols 2>/dev/null || echo 80)
            padding=$(( (cols - ${#line}) / 2 ))
            [ $padding -lt 0 ] && padding=0
            printf "%*s%s\n" $padding "" "$line"
        done
    else
        echo "                    [QR code unavailable - qrencode not installed]"
    fi
    cat << 'EOF'


                    If you call a support person, give them this info:
                    Stop code: CRITICAL_PROCESS_DIED



EOF
else
    cat << 'EOF'



                    :(
                    Your PC ran into a problem and needs to restart. We're
                    just collecting some error info, and then we'll restart
                    for you.



                    0% complete



                    For more information about this issue and possible
                    fixes, visit https://windows.com/stopcode



                    If you call a support person, give them this info:
                    Stop code: CRITICAL_PROCESS_DIED



EOF
fi

i=0
while [ $i -le 100 ]; do
    printf "\r                    %d%% complete" "$i"
    i=$((i + 1))
    sleep 0.05
done

printf "\n\n"
sleep 2
printf "\033[?25h"
tput reset
