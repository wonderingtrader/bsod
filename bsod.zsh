#!/bin/zsh

tput reset
printf "\e[44m"
printf "\e[38;2;255;255;255m"
printf "\e[2J"
printf "\e[?25l"
printf "\e]11;#0000AA\a"

if [[ "$1" == "--qrcode" ]]; then
    cat << 'EOF'



                    :(
                    Your PC ran into a problem and needs to restart. We're
                    just collecting some error info, and then we'll restart
                    for you.



                    0% complete



EOF
    qrencode -t UTF8 -i -m 0 -s 2 "https://windows.com/stopcode" | while IFS= read -r line; do
        printf "%*s\n" $((($(tput cols) - ${#line}) / 2)) "$line"
    done
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

for i in {0..100}; do
    printf "\r                    %d%% complete" "$i"
    sleep 0.05
done

printf "\n\n"
sleep 2
printf "\e[?25h"
tput reset
