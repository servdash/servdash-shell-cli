#!/bin/bash
akey=1
skey=2
servdash_memory_load(){
    memload=$(top -l 1 -n0 -s0 | awk '/PhysMem/ {print $8}' | sed 's/\([0-9]*\)M/\1/')
    echo "Memory use (mb): " $memload
}
servdash_cpu_load(){
    cpuload=$(sar 1 2 | tail -1 | awk '{print $2}')
    echo "CPU Load (%usr): " $cpuload
}
servdash_disk_usage(){
    du=$(df | grep $1'$' | awk '{print $8}' | sed s/%//)
    echo $1" disk usage (%):" $du
}
servdash_memory_load
servdash_cpu_load
servdash_disk_usage "/"
#servdash_last_ssh_login
