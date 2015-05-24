#! /bin/bash
# Edit /private/etc/hosts to block/unblock sites, BSD-like compatible
# chmod u+x hosts_toggle.sh once installed
# to run: sudo ./hosts_toggle.sh
# Assign line 11 in hosts file to blockstatus variable for comparison
# Line 11 is a comment line. Line number can be changed as needed.
blockstatus=$(sed -n 11p /private/etc/hosts);
if [ "$blockstatus" == "#Sites - BLOCKED" ]
  then
    printf "Sites are currently blocked and will be UNBLOCKED in 5 seconds. \e[0;32mPress Ctrl+C to cancel.\n\e[1;37m"
    sleep 5s 
    #Change the current Sites status 
    sed -i -e '11s/#Sites - BLOCKED/#Sites - UNBLOCKED/g' /private/etc/hosts
    #Comments out the IP addresses between lines 12 and 62, starting with the IP prefix 127 - can be changed as needed 
    sed -i -e '12,62s/127/#127/g' /private/etc/hosts
    printf "\e[0;31m Sites are UNBLOCKED - Be careful, cowboy.\n\e[1;37m"
    exit
elif [ "$blockstatus" == "#Sites - UNBLOCKED" ]
  then
    printf "Sites are currently unblocked and will be BLOCKED in 5 seconds. \e[0;32mPress Ctrl+C to cancel.\n\e[1;37m"
    sleep 5s  
    sed -i -e '11s/#Sites - UNBLOCKED/#Sites - BLOCKED/g' /private/etc/hosts
    sed -i -e '12,62s/#127/127/g' /private/etc/hosts
    printf "\e[0;32m Sites are BLOCKED - You are safe.\n\e[1;37m"
    exit
fi
