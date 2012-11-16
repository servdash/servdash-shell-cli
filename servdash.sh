#!/bin/bash
# Servdash.io Params------------------------------
akey=1
skey=2

# Script------------------------------------------
echo "$*" | grep "\-d" 2>&1 > /dev/null
debug=$?

sdashdbg(){
    [ $debug -eq 0 ] && echo -e "\033[33mSERVDASH-DBG>>> "$1"\033[0m"
}
servdash_memory_load(){
    which free 2>&1 > /dev/null
    if [ $? -eq 0 ]; then
        sdashdbg ">> using free"
        memload=$(free -m | grep Mem | awk '{print $3}')
    else
        sdashdbg ">> using top"
        memload=$(top -l 1 -n0 -s0 | awk '/PhysMem/ {print $8}' | sed 's/\([0-9]*\)M/\1/')
    fi
    echo "Memory use (mb): " $memload
}
servdash_cpu_load(){
    cpuload=$(sar 1 2 | tail -1 | awk '{print $2}')
    echo "CPU Load (%usr): " $cpuload
}
servdash_disk_usage(){
    du=$(df -P | grep $1'$' | tail -1 | awk '{print $5}' | sed s/%//)
    echo $1" disk usage (%):" $du
}
servdash_memory_load
servdash_cpu_load
servdash_disk_usage "/"
#servdash_last_ssh_login
